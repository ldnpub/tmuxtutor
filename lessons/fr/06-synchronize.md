# Synchronisation des panneaux

La synchronisation des panneaux vous permet de taper la même commande dans tous les panneaux d'une fenêtre simultanément. C'est incroyablement utile pour gérer plusieurs serveurs ou comparer différentes versions d'environnements.

## Comment essayer la synchronisation

Pour pratiquer cela tout en continuant à lire ces instructions, vous devriez ouvrir une nouvelle fenêtre :
1. Créez une nouvelle fenêtre : `PREFIX` + `c`
2. Divisez-la en 4 panneaux (utilisez `PREFIX` + `%` et `PREFIX` + `"`)
3. Dans chaque panneau, définissez un nom de variable différent :
   ```bash
   NAME=serveur1 # dans le panneau 1
   NAME=serveur2 # dans le panneau 2
   # ... et ainsi de suite
   ```

### Activer la synchronisation
Maintenant, activez la synchronisation :
`PREFIX` + `:set synchronize-panes on`

### Testez le résultat
Tapez une commande ; elle apparaîtra dans tous les panneaux à la fois :
```bash
echo "Bonjour depuis $NAME !"
```

### Désactiver
Pour arrêter la synchronisation :
`PREFIX` + `:set synchronize-panes off`

**Astuce** : Vous pouvez basculer cette option en omettant `on` ou `off` : `PREFIX` + `:set synchronize-panes`. Si vous l'utilisez souvent, vous pourriez vouloir l'associer à une touche dans votre fichier `~/.tmux.conf`.

## Scripting tmux

La synchronisation est un cas d'utilisation parfait pour le scripting tmux.

Consultez le script dans `examples/06a.synchronize-perlbrew.sh`. Il utilise `perlbrew` pour comparer quatre versions différentes de Perl. Vous pourriez l'adapter pour `pyenv`, `rbenv`, `nvm` ou tout autre outil !
