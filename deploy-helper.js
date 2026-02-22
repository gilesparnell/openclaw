// Simple deployment using Vercel API
const fs = require('fs');
const FormData = require('form-data');
const fetch = require('node-fetch');

// Get the API key from environment
const VERCEL_TOKEN = process.env.VERCEL_TOKEN || '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';

// Read the files
const files = {
  'index.html': fs.readFileSync('/home/node/.openclaw/workspace/mockups/index.html', 'utf8'),
  'mobile-proposal-1.html': fs.readFileSync('/home/node/.openclaw/workspace/mockups/mobile-proposal-1.html', 'utf8'),
  'mobile-proposal-2.html': fs.readFileSync('/home/node/.openclaw/workspace/mockups/mobile-proposal-2.html', 'utf8'),
  'vercel.json': fs.readFileSync('/home/node/.openclaw/workspace/mockups/vercel.json', 'utf8')
};

console.log('Files ready for deployment:');
Object.keys(files).forEach(file => {
  console.log(`- ${file} (${files[file].length} bytes)`);
});

console.log('\nTo deploy manually:');
console.log('1. Go to https://vercel.com');
console.log('2. Click "New Project"');
console.log('3. Drag and drop these files:');
Object.keys(files).forEach(file => {
  console.log(`   - ${file}`);
});
console.log('4. Click "Deploy"');

// Create a simple HTML viewer for local testing
const viewerHTML = `
<!DOCTYPE html>
<html>
<head>
  <title>Garion Mobile Mockups - Local Viewer</title>
  <style>
    body { font-family: system-ui; padding: 20px; }
    iframe { width: 375px; height: 812px; border: 1px solid #ccc; border-radius: 20px; margin: 10px; }
    .container { display: flex; flex-wrap: wrap; }
    .mockup { margin: 10px; }
    h2 { font-size: 14px; margin-bottom: 5px; }
  </style>
</head>
<body>
  <h1>📱 Garion Mobile Mockups</h1>
  <p>These are the two mobile proposals. Open each in a new tab to see mobile view:</p>
  <ul>
    <li><a href="./mobile-proposal-1.html" target="_blank">Proposal 1: Card-Based Dashboard</a></li>
    <li><a href="./mobile-proposal-2.html" target="_blank">Proposal 2: Activity Feed</a></li>
  </ul>
  
  <h2>Preview (375x812 - iPhone size):</h2>
  <div class="container">
    <div class="mockup">
      <h2>Proposal 1: Card Dashboard</h2>
      <iframe src="./mobile-proposal-1.html"></iframe>
    </div>
    <div class="mockup">
      <h2>Proposal 2: Activity Feed</h2>
      <iframe src="./mobile-proposal-2.html"></iframe>
    </div>
  </div>
</body>
</html>
`;

fs.writeFileSync('/home/node/.openclaw/workspace/mockups/local-viewer.html', viewerHTML);
console.log('\n📁 Local viewer created: /home/node/.openclaw/workspace/mockups/local-viewer.html');