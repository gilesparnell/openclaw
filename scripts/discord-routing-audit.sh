#!/usr/bin/env bash
set -euo pipefail

CFG_DEFAULT="$HOME/.openclaw/openclaw.json"
CFG="${1:-$CFG_DEFAULT}"

if [ ! -f "$CFG" ]; then
  echo "Config not found: $CFG"
  exit 1
fi

node - "$CFG" <<'NODE'
const fs = require('fs');
const cfgPath = process.argv[2];
const cfg = JSON.parse(fs.readFileSync(cfgPath, 'utf8'));
const d = cfg.channels && cfg.channels.discord;

if (!d || !d.enabled) {
  console.log('discord=disabled');
  process.exit(0);
}

console.log(`discord.enabled=${!!d.enabled}`);
console.log(`discord.groupPolicy=${d.groupPolicy || 'unset'}`);
console.log(`discord.requireMention_global=${d.requireMention ?? 'unset'}`);

const guilds = d.guilds || {};
const guildIds = Object.keys(guilds);
console.log(`guild.count=${guildIds.length}`);

for (const gid of guildIds) {
  const g = guilds[gid] || {};
  const channels = g.channels || {};
  const chanIds = Object.keys(channels);
  console.log(`guild.${gid}.requireMention=${g.requireMention ?? 'unset'}`);
  console.log(`guild.${gid}.channels=${chanIds.length}`);
  for (const cid of chanIds) {
    const c = channels[cid] || {};
    console.log(`channel.${cid}.allow=${c.allow ?? 'unset'} requireMention=${c.requireMention ?? 'unset'}`);
  }
}

const issues = [];
if (d.groupPolicy !== 'allowlist') issues.push('groupPolicy should be allowlist');
if (guildIds.length === 0) issues.push('no guild allowlist configured');
for (const gid of guildIds) {
  const g = guilds[gid] || {};
  const channels = g.channels || {};
  if (Object.keys(channels).length === 0) issues.push(`guild ${gid} has no allowed channels`);
}

if (issues.length === 0) {
  console.log('audit=pass');
} else {
  console.log('audit=fail');
  for (const issue of issues) console.log(`issue=${issue}`);
}
NODE
