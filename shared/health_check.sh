#!/usr/bin/env bash
set -euo pipefail

TASK_FILE="/Users/gilesparnell/Documents/VSStudio/awe2m8-local/.clawbot/active-tasks.json"
NOW_UTC="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

echo "Health monitoring check @ $NOW_UTC"
echo "task_file=$TASK_FILE"

if [ ! -f "$TASK_FILE" ]; then
  echo "status=error reason=task_file_missing"
  exit 1
fi

node -e "
const fs=require('fs');
const p=process.argv[1];
const d=JSON.parse(fs.readFileSync(p,'utf8'));
const tasks=Object.values(d.tasks||{});
const by={};
for(const t of tasks) by[t.status]=(by[t.status]||0)+1;
const terminal=(by.completed||0)+(by.failed||0);
const success=terminal>0?((by.completed||0)/terminal)*100:100;
const tracked=['health-check-component','agent-performance-metrics','system-health-alerts','monitoring-dashboard','health-monitoring-rollout'];
const health={};
for(const id of tracked){
  health[id]=d.tasks&&d.tasks[id]?d.tasks[id].status:'missing';
}
console.log('summary.total_tasks='+tasks.length);
console.log('summary.todo='+(by.todo||0));
console.log('summary.running='+(by.running||0));
console.log('summary.completed='+(by.completed||0));
console.log('summary.failed='+(by.failed||0));
console.log('summary.success_rate='+(Math.round(success*100)/100)+'%');
for (const [k,v] of Object.entries(health)) {
  console.log('health.'+k+'='+v);
}
" "$TASK_FILE"
