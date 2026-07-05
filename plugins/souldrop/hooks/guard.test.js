// Self-test for the SoulDrop safety net. Run: node guard.test.js
// Exits non-zero on any miss — used by CI and by hand before every release.
'use strict';
const { decide } = require('./guard.js');

const deny = [
  'rm -rf /', 'rm -fr ~', 'sudo rm -rf /*', 'rm -r -f $HOME', 'rm --recursive --force /',
  'del /s /q C:\\', 'rd /s /q C:\\', 'Remove-Item -Recurse -Force C:\\', 'Remove-Item -Recurse ~/',
  'diskpart', 'mkfs.ext4 /dev/sda1', 'Format-Volume -DriveLetter C', 'format C:',
  ':(){ :|:& };:', 'bomb(){ bomb|bomb& };bomb',
];
const ask = ['git reset --hard', 'git reset --hard HEAD~1', 'cd repo && git reset --hard origin/main'];
const allow = [
  'rm -rf ./build', 'rm -rf node_modules', 'rm file.txt', 'rm -rf /tmp/x', 'rm -rf ~/old-notes/tmp',
  'del /s /q .\\dist', 'Remove-Item -Recurse -Force .\\out', 'git reset --soft HEAD~1',
  'git checkout main', 'format-list', 'echo "rm -rf /" > warning.txt',
  'npm run format', 'ls -la /', 'mkdir -p ~/second-brain', 'ollama pull llama3.2:3b',
];

let fail = 0;
for (const c of deny)  { const v = decide(c); if (!v || !v.deny) { console.log('MISSED DENY :', c); fail++; } }
for (const c of ask)   { const v = decide(c); if (!v || !v.ask)  { console.log('MISSED ASK  :', c); fail++; } }
for (const c of allow) { const v = decide(c); if (v)             { console.log('FALSE BLOCK :', c, JSON.stringify(v)); fail++; } }
console.log(fail === 0
  ? 'GUARD TESTS: all ' + (deny.length + ask.length + allow.length) + ' pass'
  : 'GUARD TESTS: ' + fail + ' failure(s)');
process.exit(fail === 0 ? 0 : 1);
