# NYC Urban Infrastructure & Service Analytics

A data analytics project analyzing 3.65 million NYC 311 service requests from 2025 to understand service demand, agency workload, resolution performance, geographic variation, and relationships with socioeconomic characteristics.

## Project Overview

Municipal service request data can provide useful insights into how residents interact with city services and how requests are distributed across agencies, complaint types, and neighborhoods.

This project analyzes NYC 311 service requests for the full 2025 calendar year and combines:

- Python-based data cleaning and validation
- Geospatial analysis
- U.S. Census socioeconomic data
- MySQL analysis
- Power BI dashboard development

The analysis focuses on observed patterns in service demand and resolution performance. It does not infer causality from correlations or geographic differences.

## Key Questions

- How does NYC 311 service demand change throughout the year?
- Which agencies receive the highest number of service requests?
- Which complaint types account for the largest share of requests?
- How does resolution performance vary across agencies and boroughs?
- How does service demand vary across community boards?
- What relationships exist between service request rates and socioeconomic characteristics?

## Dataset

The analysis covers:

- **Analysis period:** January–December 2025
- **Service requests:** 3,655,040
- **Agencies:** 15
- **Complaint types:** 874
- **Community boards:** 59
- **Boroughs:** 5
- **Valid resolution records:** 3,525,111
- **Average resolution time:** 234.61 hours
- **Resolved within 24 hours:** 62.18%

### Data Sources

- NYC OpenData — 311 Service Requests
- U.S. Census Bureau — American Community Survey (2024 5-Year)
- U.S. Census Bureau — TIGER/Line geographic data
- NYC geographic boundary data

The full processed dataset is not included in this repository because of its large file size. See [`data/README.md`](data/README.md) for details.

## Tools & Technologies

| Tool | Purpose |
|---|---|
| Python | Data cleaning, validation, profiling and analysis |
| Pandas | Data manipulation |
| GeoPandas | Geospatial analysis |
| MySQL | SQL analysis and aggregation |
| Power BI | Interactive dashboard development |
| Google Colab | Python analysis environment |
| GitHub | Project documentation and version control |

## Project Workflow

```text
NYC 311 Data
     ↓
Data Recovery & Cleaning
     ↓
Data Profiling & Validation
     ↓
Geospatial Analysis
     ↓
Socioeconomic Analysis
     ↓
MySQL Analysis
     ↓
Power BI Preparation
     ↓
Dashboard & Key Findings
