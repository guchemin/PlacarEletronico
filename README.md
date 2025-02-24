# Electronic Sports Scoreboard

This project is an electronic sports scoreboard that supports three different sports: Basketball, Volleyball, and Chess. The system is designed for implementation on an Intel **DE10 FPGA** and was developed using Quartus Prime Lite as part of the Digital Circuits course.

## Features

### General Controls
- **SW9 & SW8:** Select the sport:
  - `00`: Basketball
  - `01`: Volleyball
  - `10`: Chess

### Basketball Mode
#### Screens
- **SW7 & SW6:** Select the display screen:
  - `00`: Scoreboard
  - `01`: Quarter time and shot clock
  - `10`: Fouls and current period

#### Controls
- **SW4:** Selects the team for scoring or fouls
- **SW3 & SW2:** Choose the action:
  - `00`: Add points
  - `01`: Add fouls
  - `10`: Reset shot clock
- **SW1 & SW0:** Choose the number of points (if scoring is selected):
  - `00`: 1 point
  - `01`: 2 points
  - `10`: 3 points
- **PB0:** Execute the selected action
- **PB1:** Pause/unpause the game time

### Volleyball Mode
#### Screens
- **SW7 & SW6:** Select the display screen:
  - `00`: Points and current set
  - `01`: Sets won by each team and remaining timeouts

#### Controls
- **SW1:** Selects the team for the action
- **SW0:** Selects the action:
  - `0`: Add a point
  - `1`: Request a timeout
- **PB0:** Execute the selected action

### Chess Mode
#### Controls
- **PB0:** Toggle between playing and selecting game mode
- **PB1:** Switch turns between players
- **SW3 to SW0:** Select the game mode

#### Game Modes
| SW3-SW0 | Minutes | Increment |
|---------|---------|-----------|
| 0000    | 1       | 0         |
| 0001    | 1       | 1         |
| 0010    | 3       | 0         |
| 0011    | 3       | 2         |
| 0100    | 5       | 0         |
| 0101    | 5       | 3         |
| 0110    | 10      | 0         |
| 0111    | 10      | 5         |
| 1000    | 15      | 0         |
| 1001    | 15      | 7         |
| 1010    | 30      | 0         |
| 1011    | 30      | 10        |
| 1100    | 60      | 0         |
| 1101    | 60      | 20        |
| 1110    | 90      | 0         |
| 1111    | 90      | 30        |

## Summary of Features
### Basketball
- Score, fouls, and shot clock control
- Multiple display screens
- Button controls for actions and game time management

### Volleyball
- Point, set, and timeout management
- Multiple display screens
- Button for action execution

### Chess
- Timer and turn management
- Various game modes with different time settings
- Buttons for switching turns and selecting game modes

## How to Use
1. Select the sport using **SW9 & SW8**.
2. Configure the screens and actions according to the chosen sport.
3. Use **PB0** and **PB1** to execute actions and control the game time.
4. For Chess, select the game mode using **SW3 to SW1** and manage the turns and time using the buttons.

## Development Information
- **FPGA Board:** Intel DE10
- **Development Environment:** Quartus Prime Lite
- **Course:** Digital Circuits

---
### Author
Gustavo Chemin
