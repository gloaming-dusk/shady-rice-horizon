# Changelog

## Unreleased

- Horizon has its own repository, moved out of
  [Shady](https://github.com/gloaming-dusk/shady) with its history.
- It starts from [Afterglow](https://github.com/gloaming-dusk/shady-rice-afterglow)
  with `shady.base("afterglow")` instead of reading Afterglow's files out of
  a Shady checkout, and carries its own typefaces (they were Tide's).
- A Nix package (`share/shady/rices/horizon`) and `install.sh`
  (`~/.local/share/shady/rices/horizon`), so `SHADY_RICE=horizon` keeps
  working next to Afterglow's.
