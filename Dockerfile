FROM linuxbrew/brew
ARG TAGS
WORKDIR /tmp
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -qq -y install ansible zsh
RUN chsh -s $(which zsh)
COPY . .
CMD ["sh", "-c", "ansible-playbook $TAGS planview.yml"]
