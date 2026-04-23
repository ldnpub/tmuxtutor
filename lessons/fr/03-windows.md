# Travailler avec les fenêtres

Les fenêtres dans tmux sont comme les onglets d'un navigateur Web. Vous pouvez en avoir plusieurs au sein d'une même session.

## Créer et changer de fenêtre

* **Fenêtre actuelle** : Vous êtes probablement dans la fenêtre 0.
* **Créer une nouvelle fenêtre** : Appuyez sur `PREFIX` + `c`.
* **Changer par numéro** : Appuyez sur `PREFIX` + `numéro` (ex : `0`, `1`, etc.).
* **Choisir interactivement** : Appuyez sur `PREFIX` + `w` pour choisir dans une liste.
* **Saisir un numéro** : Appuyez sur `PREFIX` + `'` (apostrophe) pour entrer un index spécifique.
* **Dernière fenêtre** : Appuyez sur `PREFIX` + `l` pour revenir à la dernière fenêtre active.
* **Suivante/Précédente** : Appuyez sur `PREFIX` + `n` (next) ou `PREFIX` + `p` (previous).

## Gérer les fenêtres

### Réorganiser les fenêtres
Pour déplacer une fenêtre vers un nouvel index :
Appuyez sur `PREFIX` + `.` (point), puis saisissez la nouvelle position. L'index cible doit être libre.

### Échanger des fenêtres
Pour échanger la fenêtre actuelle avec une autre :
* `PREFIX` + `:swap-window -t -1` (déplacer vers la gauche)
* `PREFIX` + `:swap-window -t +1` (déplacer vers la droite)

### Nommer les fenêtres
Donnez des titres significatifs à vos fenêtres pour rester organisé :
Appuyez sur `PREFIX` + `,` (virgule) et tapez le nom.

**Astuce** : Si vous ne nommez pas une fenêtre, tmux la nomme automatiquement d'après le processus en cours (ex : `bash`, `vim`, `sleep`).

## Surveiller l'activité

Vous pouvez demander à tmux de vous avertir quand quelque chose se passe dans une autre fenêtre.
1. Allez dans une autre fenêtre et lancez : `sleep 10`
2. Activez la surveillance : `PREFIX` + `:set -g monitor-activity on`
3. Revenez à cette fenêtre.
4. Quand `sleep` se termine, vous verrez une mise en évidence dans la barre d'état !

## Fermer des fenêtres

* **Quitter le shell** : Tapez `exit` ou appuyez sur `CTRL-d`.
* **Commande de fermeture** : Appuyez sur `PREFIX` + `&` (demande confirmation).
