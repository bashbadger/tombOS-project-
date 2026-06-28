# 🎨 File Wiki: style.css

## Overview
`style.css` delivers the modern, premium glassmorphism dark aesthetic for Tomb OS. It defines CSS custom properties (variables), modern typography specs (using Google Fonts 'Outfit' and monospace fonts), window management animations, and responsive UI layout rules.

## Design System Tokens & Styling Highlights

### 1. Color Palette Tokens (`:root`)
- `--ubuntu-orange`: `#E95420` (Primary action accents and active highlights)
- `--ubuntu-dark`: `#111111` / `#181818` (Deep dark background surfaces)
- `--sec-green`: `#4AF626` (Secure status badges, active terminal prompts, clean audit outputs)
- `--sec-yellow`: `#FFCC00` (Warning alerts, E2EE encryption notices)
- `--sec-red`: `#FF3B30` (Threat blocks, AppArmor violations, live recording indicators)

### 2. Glassmorphism & Backdrop Filters
- Window titles and modals utilize `backdrop-filter: blur(20px)` with translucent backgrounds (`rgba(30,30,30,0.75)`) for an ultra-modern desktop feel.

### 3. Micro-Animations & Transitions
- Includes smooth fade-in (`@keyframes fadeIn`), window focus elevations, dock icon bounce transitions, and button hover glows.

---
*Back to [Master Technical Wiki](../WIKI.md)*
