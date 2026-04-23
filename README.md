# 🪟 tmuxtutor (Modernized)

> **Learn tmux by doing, not just by reading.**

`tmuxtutor` is a brief, interactive tutorial for the **tmux** terminal multiplexer, heavily inspired by the classic `vimtutor`. 

This version is a **modernized fork** of the original project by [perlpunk](https://github.com/perlpunk/tmuxtutor), rebuilt from the ground up as a standalone, interactive Bash script.

---

## ✨ Features

- **🚀 Interactive Validation**: The tutor doesn't just show text; it monitors your tmux session and knows when you've successfully completed a task (like opening a clock or splitting a pane).
- **🌗 Split-Screen Learning**: Instructions stay in the top pane while you practice in the bottom pane.
- **🌍 Bilingual Support**: Available in both **English** and **French** (auto-detected or manually selected).
- **📦 Zero Dependencies**: No Perl, no Swim, no extra tools. Just `bash` and `tmux`.

---

## 🛠 Installation & Usage

### Quick Start

1. **Clone the repository**:
   ```bash
   git clone git@github.com:ldnpub/tmuxtutor.git
   cd tmuxtutor
   ```

2. **Run the tutor** (make sure you are **outside** of a tmux session):
   ```bash
   ./tmuxtutor.sh
   ```

### 🇫🇷 Utilisation en Français

Le script détecte automatiquement votre langue via la variable `$LANG`. Pour forcer le français manuellement :
```bash
./tmuxtutor.sh fr
```

---

## 🚪 How to Quit / Comment quitter

### English
To exit the tutorial at any time:
1.  **Detach** from the session: Press `Ctrl-b` then `d`.
2.  **Kill** the session (and the tutorial loop):
    ```bash
    tmux kill-session -t tmuxtutor
    ```
3.  Alternatively, you can just type `exit` in each pane until the window closes.

### Français
Pour quitter le tutoriel à tout moment :
1.  **Se détacher** de la session : Appuyez sur `Ctrl-b` puis `d`.
2.  **Arrêter** la session (et la boucle du tutoriel) :
    ```bash
    tmux kill-session -t tmuxtutor
    ```
3.  Sinon, vous pouvez simplement taper `exit` dans chaque panneau jusqu'à ce que la fenêtre se ferme.

---

## 📚 Lessons Included

| Lesson | Topic | Interactive |
| :--- | :--- | :---: |
| 00 | Introduction & Requirements | 📖 |
| 01 | The Prefix Key & The Clock | ✅ |
| 02 | Basic Navigation | 📖 |
| 03 | Working with Windows | ✅ |
| 04 | Mastering Panes | ✅ |
| 05 | Layouts | 📖 |
| 06 | Synchronizing Panes | 📖 |

---

## 🤝 Credits

This project is a labor of love to keep the spirit of the original `tmuxtutor` alive. 

- **Original Content & Pedagogy**: [perlpunk/tmuxtutor](https://github.com/perlpunk/tmuxtutor).
- **Modernization & Bash Engine**: [ldnpub](https://github.com/ldnpub/tmuxtutor).

---

## 📄 License

This project is licensed under the same terms as the original (check the original repository for details).
