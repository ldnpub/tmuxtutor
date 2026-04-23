# Les bases de tmux

Bienvenue dans la première leçon ! Vous apprendrez ici les commandes fondamentales pour naviguer et interagir avec tmux.

## La touche Prefix

Chaque commande dans tmux commence par un **PREFIX**. Par défaut, il s'agit de :
`CTRL-b`

### Navigation essentielle

* Pour quitter un dialogue tmux, un affichage ou ce tutoriel : appuyez sur `q` ou `ESCAPE`.
* Pour voir les derniers messages d'erreur (qui disparaissent souvent rapidement) : appuyez sur `PREFIX` + `~` (tilde).

## Commandes de base

Essayons quelques commandes. N'oubliez pas d'appuyer d'abord sur le **PREFIX** (`CTRL-b`), puis sur la touche de commande.

### Afficher l'heure
Appuyez sur `PREFIX` + `t`. Vous devriez voir une grande horloge. Appuyez sur n'importe quelle touche pour la fermer.

### Lister tous les raccourcis
Appuyez sur `PREFIX` + `?`. Cela affiche toutes les touches actuellement associées à des commandes. Utilisez `q` pour quitter cette liste.

## Mode ligne de commande

Bien que les commandes les plus courantes soient associées à des touches, vous pouvez également saisir des commandes manuellement.

### Entrer en mode commande
Appuyez sur `PREFIX` + `:`. Vous verrez une invite en bas de l'écran.

### Essayer une commande
Tapez `clock-mode` et appuyez sur `Enter`.
Vous pouvez utiliser la **complétion par Tabulation** : tapez `:clo` puis appuyez sur `Tab`.

### Exécuter des commandes tmux depuis le shell
Vous pouvez également exécuter des commandes depuis votre invite de shell habituelle :
```bash
tmux clock-mode
```
Si vous êtes dans une session tmux, elle s'y exécutera. Sinon, elle ciblera la session la plus récemment utilisée.

Pour cibler un panneau spécifique :
```bash
tmux clock-mode -t play:0.1 # session 'play', fenêtre 0, panneau 1
```

## Sessions

Une **session** tmux peut contenir plusieurs **fenêtres**, et chaque fenêtre peut contenir plusieurs **panneaux**.

Ce tutoriel s'exécute dans une session nommée `demo` (visible dans la barre d'état en bas).

### Détachement et rattachement
* **Se détacher** de la session actuelle : `PREFIX` + `d`. Vous reviendrez à votre shell normal.
* **Se rattacher** à la session :
  ```bash
  tmux attach -t demo
  ```
* **Lister toutes les sessions** :
  ```bash
  tmux ls
  ```

Essayez de vous détacher maintenant et de vous rattacher pour voir comment cela fonctionne !
