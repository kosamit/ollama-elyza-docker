FROM ollama/ollama:0.2.7

RUN apt-get install -y curl

COPY ./ollama-elyza /root/ollama-elyza

RUN if [ ! -f /root/ollama-elyza/Llama-3-ELYZA-JP-8B-q4_k_m.gguf ]; then \
      apt-get install -y curl; \
      curl -L https://huggingface.co/elyza/Llama-3-ELYZA-JP-8B-GGUF/resolve/main/README.md -o /root/ollama-elyza/README.md; \
      curl -L https://huggingface.co/elyza/Llama-3-ELYZA-JP-8B-GGUF/resolve/main/Llama-3-ELYZA-JP-8B-q4_k_m.gguf?download=true -o /root/ollama-elyza/Llama-3-ELYZA-JP-8B-q4_k_m.gguf; \
    fi

RUN nohup bash -c "ollama serve &" && sleep 5 && ollama create elyza:jp8b -f /root/ollama-elyza/Modelfile

EXPOSE 11434

CMD ["serve"]
