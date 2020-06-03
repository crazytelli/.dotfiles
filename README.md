# dotfiles
Todos os `dotfiles` são gerenciados com `GNU/stow`.

## Como clonar o repositório

- Clonar o repositório para `$HOME`
- Em seguida mover para o diretório `cd ~/dotfiles/stow`

Para o `stow` criar os *links simbólicos* apropriados, o comando deve ser usado no caminho correto.

Utilizar o comando: `stow -nvt ~ *`

## Flags

- A flag `-n` não executa o comando, apenas permite que possamos ver qual será o resultado.
- A flag `-v` significa verbose, mostra em texto o que está sendo feito no background.
- A flag `-t` serve para apontar o diretório onde os links serão criados, no caso será na home `~/`

Para desfazer o comando basta fazer:

`cd ~/dotfiles/stow`
`stow -vD *`
