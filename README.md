# 🧩 Boggle Solver in Elixir

This project is a Boggle word solver implemented in Elixir.  
Given a letter board and a dictionary of valid words, the solver efficiently finds all possible words that can be formed according to Boggle rules, returning both the words and their coordinates on the board.

---

## 🚀 Features
- **Full Boggle Search** – Works for any NxM board size (tested from `2x2` up to `16x16`).
- **Dictionary-Based Validation** – Uses preloaded word lists to ensure valid words only.
- **Coordinate Tracking** – Returns the exact path for each found word.
- **Optimized Search** – Utilizes prefix pruning to avoid exploring invalid word paths.
- **Extensive Test Coverage** – Multiple test boards with scoring validation.

---

## ⚙️ How It Works
1. **Load Dictionary** – The solver reads a `.txt` word list into a `MapSet` for O(1) lookups.
2. **Generate Prefix Map** – A helper map of all possible word prefixes is built to allow pruning of invalid search paths early.
3. **DFS Search** – For each board cell:
   - Start building words character by character.
   - Stop exploring if the current prefix does not exist in the prefix map.
   - Record the path if the built word exists in the dictionary.
4. **Return Results** – A map of `{ word => [coordinates] }` is returned.

---

## 🧪 Running the Project

### 1️⃣ Install Dependencies
```bash
mix deps.get
```


<img width="353" height="178" alt="image" src="https://github.com/user-attachments/assets/ca74d265-5840-4151-bbae-440c58b6beaf" />
