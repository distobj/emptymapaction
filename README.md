emptymapaction
==============

Empty Map Action is a sourcemod plugin that takes an action on the map (restart or next-map) when the last human disconnects

It is intended for servers that don't hibernate (eg. via tf_allow_server_hibernation or, effectively, tf/sm_bot_join_after_player from Bot Manager)
so that server settings that have been changed by admins or via voting, can be reset. It can also help accelerate progress through the mapcycle
if the server has a large list (using the next-map action).

It has been tested only with TF2, and doesn't support workshop maps.

## Download & Installation

Download emptymapaction.smx file from [releases](https://github.com/distobj/emptymapaction/releases) and put it in your /tf/addons/sourcemod/plugins directory.

Optionally, configure by updating your server.cfg. Default behaviour is to enable the plugin and restart the map.

Then restart the server, or load via ``sm plugins load emptymapaction``.

## Commands

None

## ConVars

- ``sm_emptymapaction_enable``: 0 or 1 for disable/enable (default 1)
- ``sm_emptymapaction_action``: 0 or 1 for restart/next-map (default 0)
