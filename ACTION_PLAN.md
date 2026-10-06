# ACTION PLAN – Portfolio Improvement (Easy, Step-by-Step)

> Do in order. Check off each step as you complete it. This is designed to avoid procrastination (small 5–60 min tasks).

## PHASE 1: Make Your Live Portfolio Work (Must Do First) – 5 MIN

### Task 1: Enable GitHub Pages
- [ ] Go to [Portfolio Repo Settings → Pages](https://github.com/agp-369/Portfolio-Data-Analytics/settings/pages)
- [ ] Under "Source", select **Deploy from a branch**
- [ ] Branch: `main` → Folder: `/(root)` → Click **Save**
- [ ] Wait 30–60 seconds. Open: [https://agp-369.github.io/Portfolio-Data-Analytics/](https://agp-369.github.io/Portfolio-Data-Analytics/)
- [ ] Verify it loads (should show your portfolio homepage). If 404, wait 1 more minute and refresh.

### Task 2: Add Live URL to Main README (Fix Repo Presentation) – 2 MIN
- [ ] Open `C:\Users\abhis\Downloads\Kaggle\Portfolio-Data-Analytics\README.md`
- [ ] Add this line right below the title/badges (near top):
  ```markdown
  **Live Portfolio:** [https://agp-369.github.io/Portfolio-Data-Analytics/](https://agp-369.github.io/Portfolio-Data-Analytics/)
  ```
- [ ] Save file
- [ ] Commit + Push:
  ```bash
  cd C:\Users\abhis\Downloads\Kaggle\Portfolio-Data-Analytics
  git add README.md
  git commit -m "Add live GitHub Pages URL to README"
  git push
  ```

## PHASE 2: Clean Up Repo Noise – 1 MIN

### Task 3: Remove Executed Notebook (Keep Repo Clean)
- [ ] Delete: `project-3-movies-data-analysis/movies_analysis_executed.ipynb`
- [ ] Commit + Push:
  ```bash
  cd C:\Users\abhis\Downloads\Kaggle\Portfolio-Data-Analytics
  git add -A
  git commit -m "Remove executed notebook to keep repo clean"
  git push
  ```

## PHASE 3: Interactive Dashboard (Biggest ROI) – 30–60 MIN

### Task 4: Publish Nashville Housing Dashboard on Tableau Public
1. **Prepare Data** – Use cleaned CSV: `project-2-nashville-housing-cleaning/data/nashville_clean.csv`
2. **Sign Up** – Create free account at [Tableau Public](https://public.tableau.com/app/discover)
3. **Create Workbook**
   - [ ] Upload `nashville_clean.csv`
   - [ ] Create **KPI Cards**: Total Sales, Avg Sale Price, Number of Properties Sold
   - [ ] Create **Line Chart**: Sales Over Time (use `sale_date_converted` → Month/Year)
   - [ ] Create **Bar Chart**: Top Cities by Total Sales (`property_split_city`)
   - [ ] Create **Map** (optional but nice): Sales by City
   - [ ] Create **Donut/Pie**: `SoldAsVacant` (Yes/No)
   - [ ] Add **Filters**: City, Year (make it interactive for non-technical users)
4. **Publish to Public**
   - [ ] File → Publish to Tableau Public → Name: `Nashville Housing Sales Dashboard`
   - [ ] Publish. Copy the **Share/Public URL** (looks like `https://public.tableau.com/app/profile/.../viz/.../Dashboard1`)
5. **Add to Project**
   - [ ] Create folder `project-2-nashville-housing-cleaning/dashboards/` (if not exists)
   - [ ] Take a quick screenshot of dashboard → Save as `nashville_housing_dashboard.png` in `dashboards/`
   - [ ] Edit `project-2-nashville-housing-cleaning/README.md` → Add section at bottom:
     ```markdown
     ## Interactive Dashboard
     [View Live Dashboard on Tableau Public](PASTE_YOUR_TABLEAU_PUBLIC_URL_HERE)
     
     ![Nashville Housing Dashboard](./dashboards/nashville_housing_dashboard.png)
     ```
   - [ ] Edit `README.md` (Main Portfolio) → Under Project 2, add small link: `| [Dashboard](PASTE_URL)` or update description
   - [ ] Save, Commit + Push
     ```bash
     cd C:\Users\abhis\Downloads\Kaggle\Portfolio-Data-Analytics
     git add -A
     git commit -m "Add Tableau Public Nashville Housing dashboard"
     git push
     ```

## PHASE 4: Pin Your Best Projects (Profile Boost) – 1 MIN

### Task 5: Pin Top 3 on GitHub Profile
- [ ] Go to [Your GitHub Profile](https://github.com/agp-369)
- [ ] Click `Customize your pins` (or Pinned → Customize)
- [ ] Pin these 3 (in this order for max impact):
  1. `Portfolio-Data-Analytics` (or highlight portfolio) OR `project-2-nashville-housing-cleaning`? Better pin **repo** + key projects. Recommended: Pin **Portfolio-Data-Analytics**, **Nashville Housing Cleaning**, **TMDB Movies EDA**, **COVID-19 SQL Exploration** → Choose **Top 3**: Nashville, TMDB, COVID SQL
- [ ] Save Pins

## PHASE 5: Colab Badges (Consistency) – 2 MIN

### Task 6: Add Colab Badge to All Python Notebooks
- [ ] Check notebooks: Only TMDB has badge (now fixed). No other `.ipynb` files exist. If you add any later, use this badge format (replace path):
  ```markdown
  [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/agp-369/Portfolio-Data-Analytics/blob/main/project-3-movies-data-analysis/movies_analysis.ipynb)
  ```
- [ ] (Optional now) – TMDB already has it. Skip if done.

## PHASE 6: Create Project 5 – API + Automation + ML + Docker (Biggest Standout) – 2–3 HOURS

> Do this in small chunks. Don’t try to finish in one go. 20-min blocks work best.

### Task 7: Create Folder Structure – 1 MIN
- [ ] Create folder: `C:\Users\abhis\Downloads\Kaggle\Portfolio-Data-Analytics\project-5-cve-vulnerability-trends\`
- [ ] Inside create: `data/`, `notebooks/`, `sql/`, `dashboards/`, `scripts/`

### Task 8: Write requirements.txt – 30 SEC
- [ ] Create `project-5-cve-vulnerability-trends/requirements.txt`:
  ```txt
  requests>=2.31.0
  pandas>=2.0.0
  numpy>=1.24.0
  matplotlib>=3.7.0
  seaborn>=0.13.0
  scikit-learn>=1.3.0
  python-dateutil>=2.8.2
  ```

### Task 9: Fetch Live CVE Data (API) – 15 MIN
- [ ] Create `project-5-cve-vulnerability-trends/scripts/fetch_cves.py`
  - Pull last 30 days from [NVD CVE API](https://nvd.nist.gov/developers/vulnerabilities) (free, no key needed for small pulls)
  - Save raw JSON → `data/cve_raw.json`
  - Flatten to CSV → `data/cve_clean.csv`
  - Handle pagination + basic rate limiting
- [ ] Test run once → Verify CSV has 100–1000+ rows (real, messy data)

### Task 10: EDA + Trend Analysis – 30 MIN
- [ ] Create `project-5-cve-vulnerability-trends/notebooks/cve_eda.ipynb`
  - Load CSV, explore nulls/duplicates (show messy data handling)
  - Analyze: CVEs by severity (CVSS), top vendors/products, trends over time
  - Create 3–4 visuals (bar, line over time, severity distribution)
  - Save charts to `dashboards/`

### Task 11: Simple Predictive Model (Pragmatic) – 40 MIN
- [ ] In same notebook or new: Try simple ML (e.g., predict CVSS severity/class or trend next 7–14 days using time features). Use `scikit-learn` (LogisticRegression/RandomForest). Keep it simple & explainable.
- [ ] Show train/test, basic metrics (accuracy/precision/recall). Focus on **interpretation** > complexity.

### Task 12: Dockerize It (Automation Proof) – 20 MIN
- [ ] Create `project-5-cve-vulnerability-trends/Dockerfile`:
  ```dockerfile
  FROM python:3.11-slim
  WORKDIR /app
  COPY requirements.txt .
  RUN pip install --no-cache-dir -r requirements.txt
  COPY . .
  CMD ["python", "scripts/fetch_cves.py"]
  ```
- [ ] Test: `docker build -t cve-trends .` (optional if Docker installed) — document in README if not tested.

### Task 13: Write Professional README for Project 5 – 20 MIN
- [ ] Create `project-5-cve-vulnerability-trends/README.md` with:
  - **Business Problem**: “Security teams need to track emerging CVE vulnerabilities to prioritize patching with limited resources. Without trend data, critical vulns get buried.”
  - **Data Source**: NVD CVE API (unconventional, live)
  - **Methodology**: API extraction → JSON flattening → cleaning (messy nested data) → SQL/EDA → trend analysis → simple predictive model → containerized automation
  - **Key Insights**: Top vendors, severity distribution, weekly/monthly trends, peak windows
  - **Actionable Recommendations**: Prioritize Critical/High by CVSS, focus on top recurring vendors, automate daily pull for early alerts
  - **How to Run** (local + Docker)
  - **Tools**: Python, Requests, Pandas, Scikit-learn, Docker, Matplotlib/Seaborn

### Task 14: Push Project 5 – 1 MIN
```bash
cd C:\Users\abhis\Downloads\Kaggle\Portfolio-Data-Analytics
git add project-5-cve-vulnerability-trends
git commit -m "Add Project 5: CVE Vulnerability Trends (API + Automation + ML + Docker)"
git push
```

## PHASE 7: Final Polish – 5 MIN

### Task 15: Update Main README (Remove “Planned”, Add Project 5) – 2 MIN
- [ ] Edit `README.md` → Add Project 5 to Projects table (live, original, API+ML+Docker). Remove any “planned/coming soon” placeholders.

### Task 16: Verify Everything – 3 MIN
- [ ] Pages URL loads clean ([live link](https://agp-369.github.io/Portfolio-Data-Analytics/))
- [ ] Repo shows clean README (no placeholder text)
- [ ] All 5 projects visible, READMEs have Business Problem + Actionable Recommendations
- [ ] Tableau link works (open in incognito)
- [ ] Colab badge works (TMDB)

## WHAT’S LEFT VS DONE

| Remaining (Critical) | Status | Impact |
|---|---|---|
| **GitHub Pages Enable** (Task 1) | DO NOW | Fixes live URL (shows up properly) |
| **Tableau Dashboard** (Task 4) | HIGH | Proves “present to non-technical stakeholders” |
| **Project 5 (API+ML+Docker)** | HIGHEST | Makes you stand out vs 90% of applicants |
| **Pin Projects** (Task 5) | Quick Win | Profile looks stronger |

**Minimum to be solid this week:** Tasks 1–5 (Pages + Tableau + Pins) = ~1 hour max.  
**To be genuinely competitive:** Add Task 7–15 (Project 5) = +2–3 hours total. That’s the biggest leap.