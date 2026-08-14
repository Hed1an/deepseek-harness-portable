// DeepSeek Harness 便携版一键启动器
// 双击 启动.bat 即可:自动找空闲端口 → 启动服务 → 自动打开浏览器
// 数据目录在包内 data\ 下,完全绿色,不影响系统环境
const { spawn } = require('child_process');
const http = require('http');
const path = require('path');
const fs = require('fs');

const ROOT = __dirname;
const NODE_DIR = path.join(ROOT, 'node');
const DSH_BIN = path.join(ROOT, 'app', 'node_modules', '.bin', 'dsh.cmd');

// 数据目录收进包内(绿色运行)
process.env.DSH_HOME = path.join(ROOT, 'data');
process.env.PATH = NODE_DIR + ';' + process.env.PATH;

function portFree(port) {
  return new Promise((resolve) => {
    const s = http.createServer();
    s.once('error', () => resolve(false));
    s.once('listening', () => s.close(() => resolve(true)));
    s.listen(port, '127.0.0.1');
  });
}

function waitUp(port, tries) {
  return new Promise((resolve) => {
    let n = 0;
    const t = setInterval(() => {
      const req = http.get(`http://127.0.0.1:${port}/`, (r) => { clearInterval(t); resolve(true); });
      req.on('error', () => { if (++n >= tries) { clearInterval(t); resolve(false); } });
    }, 1000);
  });
}

async function main() {
  // 1. 找空闲端口(默认 3080,被占用自动 +1)
  let port = 3080;
  for (let i = 0; i < 10; i++) {
    if (await portFree(port)) break;
    console.log(`[dsh] 端口 ${port} 被占用,尝试 ${port + 1}`);
    port++;
  }

  console.log(`[dsh] 正在启动 DeepSeek Harness ... (http://127.0.0.1:${port})`);
  const child = spawn('cmd', ['/c', DSH_BIN, 'web', '--port', String(port)], {
    stdio: 'inherit',
    env: process.env,
    cwd: ROOT,
  });

  // 2. 等就绪后自动打开默认浏览器
  if (await waitUp(port, 60)) {
    console.log(`[dsh] 就绪!正在打开浏览器 ...`);
    spawn('cmd', ['/c', 'start', '', `http://127.0.0.1:${port}`], { stdio: 'ignore', detached: true }).unref();
  } else {
    console.log('[dsh] 服务未能就绪,请查看上方日志');
  }

  // 3. 服务退出后自动关窗
  child.on('exit', (code) => {
    console.log(`[dsh] 服务已停止 (exit ${code}),5 秒后关闭窗口`);
    setTimeout(() => process.exit(0), 5000);
  });
}

main();
