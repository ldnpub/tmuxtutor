# Bienvenue dans tmuxtutor !

Ce tutoriel vous guidera à travers les bases de **tmux**, un puissant multiplexeur de terminaux.

## Prérequis

* **tmux** installé sur votre système.
* Connaissance de base de la navigation dans une page `man` ou la commande `less`.
* Savoir ce qu'est la touche **Meta** (ou **Alt**).

## Expérience Interactive

Ce tutoriel est conçu pour une **expérience interactive en écran scindé**. Vous lisez probablement ceci dans un panneau tout en effectuant des actions dans un autre.

La version HTML est également disponible sur : [https://perlpunk.github.io/tmuxtutor/](https://perlpunk.github.io/tmuxtutor/)

La plupart des leçons commencent par une commande telle que :

```bash
tmux new-session -s demo "man man/01.basics.man"
```

Cela lance une nouvelle session tmux nommée `demo` et exécute la commande `man`. Si vous quittez `man` avec `q`, la fenêtre tmux (et la session, s'il s'agit de la seule fenêtre) se fermera.

### Session d'Entraînement

Si vous souhaitez expérimenter librement, lancez votre propre session nommée :

```bash
tmux new-session -s play
```

## Configuration

Ce tutoriel suppose un fichier `~/.tmux.conf` par défaut. Si vous avez déjà personnalisé votre configuration, certains comportements ou visuels pourraient différer.

## Prêt à commencer ?

Quittez cette introduction en appuyant sur `q`, puis passez à la leçon suivante :

```bash
./01.basics.sh
```
