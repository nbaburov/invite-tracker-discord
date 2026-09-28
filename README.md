# Discord Invite Tracker

A Discord bot that records which invite link each new member joined through and who created it, and reports invite statistics per member with slash commands.

> Shared as a reference. Not actively maintained for external contributions.

## What it does

| Command | Who can use it | Result |
|---|---|---|
| `/createinvite <user> [channel]` | members with Create Invite and Manage Server | creates a permanent, unlimited invite in the channel (default: current) and tracks it for `<user>` |
| `/invites [user]` | members with Manage Server | total uses of the user's invites (default: yourself) and their active links |
| `/detailed-invites [user] [show_all]` | members with Manage Server | the same, plus who joined through each link and when: the latest 10, or all with `show_all` |

These are default permissions; server admins can change who sees each command under Server Settings → Integrations.

On start the bot snapshots every invite in each server it is in. When someone joins, it finds the invite whose use count went up and records the new member against it. Data is kept in a JSON file, so it survives restarts.

## Quickstart

Requires Python 3.10+ and a bot application from the [Discord Developer Portal](https://discord.com/developers/applications) with the **Server Members** privileged intent enabled. Invite it with the `bot` and `applications.commands` scopes and the Manage Server and Create Invite permissions (listing invites needs Manage Server).

```bash
git clone https://github.com/nixxxo/invite-tracker-discord.git
cd invite-tracker-discord
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env    # set DISCORD_TOKEN
python app.py
```

Slash commands are registered when the bot starts.

## Architecture

A single script, `app.py`, on [py-cord](https://github.com/Pycord-Development/pycord).

| Part | Responsibility |
|---|---|
| `on_ready` | syncs slash commands, loads each server's current invites into the tracker |
| `on_member_join` | compares invite use counts to attribute the join, then saves |
| slash commands | create tracked invites and render statistics as embeds |
| `load_invites` / `save_invites` | read and write the JSON store |

## Configuration

| Variable | Required | Default | Description |
|---|---|---|---|
| `DISCORD_TOKEN` | yes | | bot token |
| `INVITES_FILE` | no | `invites.json` | path of the JSON store |

The store holds Discord user IDs, usernames and join times, so it is gitignored.

## License

MIT: see [LICENSE](LICENSE).
