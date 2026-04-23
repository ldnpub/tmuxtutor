# Personnaliser la touche Prefix

Vous n'êtes pas obligé de conserver le `CTRL-b` par défaut. De nombreux utilisateurs préfèrent d'autres combinaisons comme `CTRL-a` (style classique screen) ou `CTRL-space`.

## Pourquoi la changer ?

* **Ergonomie** : Certaines touches sont plus faciles d'accès que d'autres.
* **Pair Programming** : Si vous travaillez à plusieurs, assurez-vous que tout le monde est à l'aise avec le préfixe choisi.

## Comment la changer

Vous pouvez modifier le préfixe dans votre fichier `~/.tmux.conf`. Voici un exemple pour le changer en `CTRL-a` :

```tmux
# Changer la touche de préfixe par défaut en CTRL-a
unbind-key C-b
set -g prefix C-a

# Permettre l'envoi d'un CTRL-a littéral en appuyant deux fois sur CTRL-a
# (Utile pour aller au début d'une ligne dans le shell)
bind-key a send-prefix

# Alternativement, vous pouvez utiliser CTRL-a CTRL-a :
# bind-key C-a send-prefix
```

Après avoir modifié votre configuration, vous devrez redémarrer tmux ou recharger le fichier pour que les changements prennent effet :
```bash
tmux source-file ~/.tmux.conf
```
