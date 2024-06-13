# qbcore Vibes Blip Duty README

This script allows you to toggle blips on and off when the player goes on duty in the qbcore framework.

## Installation

1. Make sure you have the qbcore framework installed in your FiveM server.
2. Download the `vibes-blip-duty` resource from the [GitHub repository](https://github.com/Keekay-OD/vibes-blip-duty).
3. Place the `vibes-blip-duty` folder in the `resources` directory of your FiveM server.

## Usage

1. Start your FiveM server.
2. Add `ensure vibes-blip-duty` to your `server.cfg` file.
3. Join the server as a player.
4. When you go on duty, blips will be displayed on the map. When you go off duty, the blips will be hidden.

## Configuration

You can customize the behavior of the script by modifying the `config.lua` file in the `toggle_blips` folder. Here are the available options:

- `blipSprite`: The sprite ID of the blip to be displayed.
- `blipColor`: The color of the blip.
- `blipScale`: The scale of the blip.
- `showBlipsOnDuty`: Whether to show blips when the player goes on duty.
- `showBlipsOffDuty`: Whether to show blips when the player goes off duty.

## Contributing

Contributions are welcome! If you have any suggestions, bug reports, or feature requests, please open an issue or submit a pull request on the [GitHub repository](https://github.com/Keekay-OD/vibes-blip-duty).

## License

This script is licensed under the [MIT License](https://opensource.org/licenses/MIT).
