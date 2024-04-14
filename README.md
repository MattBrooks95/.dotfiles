## Fonts
### Berkely Mono
Berkeley Mono is licensed, so don't check it into git. You saved in Google Drive.

Incase you lose your version of Berkeley Mono that is patched with NerdFonts, you can use a bash script like this to make patching a bit easier
```bash
FONT_DIR=berkeley-mono
OUT_DIR=output

for file in `fd -e ttf . berkeley-mono`; do
	nerd-font-patcher -c --mono --adjust-line-height -out "$OUT_DIR" file
done
```
where -c means "complete nerd font icon collection", --mono "means make everything monospaced", --adjust-line-height must be necessary? it was in the article, and -out specifies the output directory that will contain the patched font files
*NOTE* you need to do something like `$ nix-shell -p nerd-font-patcher` to get a temporary shell that has the nerd font CLI for patching files

and then run `$ fc-cache` to update the OS's font list, then check with `$ fc-list` that the Berkeley fonts are there

In order for some Neovim plugins to look nice, you need [NerdFonts](https://www.nerdfonts.com/) Nerd fonts is a collection of extra icons, that need to be 'patched in'. If you're still on NixOs, there is a nerd-font-patcher package that provides the CLI to do this

[this article is helpful for patching](https://tech.serhatteker.com/post/2023-04/patch-berkeley-mono-font-with-nerd-fonts/)
