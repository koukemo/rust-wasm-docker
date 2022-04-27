import init, { greet } from '../pkg/wasm_deno_sample.js';
async function run() {
  const file = await fetch('../public/pkg/wasm_deno_sample_bg.wasm'); 
  await init(file);
  greet('koukemo');
}
run();