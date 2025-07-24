# ElectricityEurope

Finished

diagramm: https://drawsql.app/teams/alone-173/diagrams/electricity
Dashboard: https://public.tableau.com/views/OfficialDashboards/Story1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link


Overview

This project provides a technical exploration of electricity generation, demand, and MtCO₂e emissions across European countries between 1990 and 2024. It integrates data engineering, descriptive analytics, and visual reporting to:

    Track long-term trends in electricity generation by source

    Analyze national energy demand levels across the EU

    Evaluate emissions trajectories over time

    Enable visual and interactive insights via Tableau Dashboards

This project is built as part of a portfolio to demonstrate competency in:

    SQL-based querying and filtering

    Spreadsheet modeling and transformation (Excel)

    Interactive data visualization (Tableau)

Data Sources and Scope

The data covers:

    Annual electricity generation (TWh) by source (e.g. fossil, renewable, nuclear)

    Country-level electricity demand (TWh)

    Emissions in MtCO₂e from generation activity

    Time range: 1990–2024 (where available)

    Geographic scope: EU-27 countries + select neighbors

Tools & Technologies
Tool	Purpose
MySQL	Data extraction and transformation (joins, filters, year-over-year metrics)
Excel	Data modeling, pivoting, initial trend analysis, graphing
Tableau	Dashboard development, map visualization, interactive filtering
Structure & Methodology
1. Electricity Generation (Full Mix)

    Visualization: Stacked bar chart (by generation type, annually)

    Metric: Sum of Generated_TWh

    Objective: Track decarbonization progress by monitoring shifts in generation type

    Insights:

        Notable increase in renewables post-2015 (wind, solar)

        Gradual decline in coal and lignite

        Gas shows variability due to geopolitical dependencies

2. Demand Analysis by Country

    Visualization: Choropleth map + horizontal bar chart

    Metric: Sum of Demand_TWh per country (2010–2024)

    Objective: Identify major consumers and compare regional energy demands

    Insights:

        Top consumers: Germany, France, Italy

        Demand largely correlates with population, industry, and economic output

        Eastern Europe shows lower demand but steady growth

3. CO₂ Emissions Analysis

    Visualization: Time-series + YoY change bars

    Metric: Total MtCO₂e from generation

    Objective: Evaluate whether generation trends align with emission targets

    Insights:

        Steady decline in emissions from 2007 onward

        Major drops post-2019 hint at renewable transition

        Peak years align with fossil fuel usage surges (e.g., post-2000 gas growth)

Interactive Dashboard Links

    🔎 Overview Dashboard (Tableau)
    Contains generation trends, emissions trajectories, and demand comparisons

    📋 Table Overview
    Shows the structured dataset and dimensions used in visuals

Analytical Motivation & Design Rationale

Although developed as a beginner-level portfolio project, this repository aims to reflect structured thinking in the field of energy data analytics:

    Time-series trends were chosen to show energy transitions in a temporal context

    Geographical breakdown allows linking technical trends to policy and national profiles

    Emissions tracking was integrated to assess environmental impacts of energy shifts

    Interactive visuals allow filtering by area and generation type for scenario-specific insights

This foundational structure can be extended toward:

    Forecasting models

    Policy-effect simulations

    Multi-variable correlation analysis (e.g., GDP, policy events, imports)

Potential Geopolitical or Policy Drivers Reflected in Data

    Germany’s Nuclear Phase-Out (Energiewende): Steady drop in nuclear, offset by wind/solar

    2022 Energy Crisis: Spikes in gas and coal usage in some nations

    EU Green Deal Targets: Observable decline in emissions and fossil generation post-2019

    Carbon Pricing (ETS): Emissions intensity reduction post-policy periods

    COVID-19: Drop in total demand and emissions during 2020–2021

Future Work & Extensions

    Integrate additional indicators (imports, pricing, subsidies)

    Add policy timelines overlaid on generation/emission charts

    Include CAGR and delta metrics for regions and sources

    Build forecasting models based on historical trends

    Export Tableau visualizations into web-embeddable formats

Author & Acknowledgement

This project was developed by a data analytics beginner as part of a personal learning journey.
Feedback, suggestions, or contributions are welcome via issues.
