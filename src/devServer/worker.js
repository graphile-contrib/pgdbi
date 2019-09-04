const { Pool } = require("pg");
const { run } = require("graphile-worker");

const pgPool = new Pool({
  connectionString: "postgres://postgres:1234@0.0.0.0/pg_phile_starter",
});

async function main() {
  const runner = await run({
    pgPool,
    // or: connectionString: process.env.DATABASE_URL,

    concurrency: 1,
    pollInterval: 2000,

    taskList: {
      testTask: async (payload, { debug }) => {
        console.log(`Received ${JSON.stringify(payload)}`);
        throw new Error('bad things, man')
      },
    },
    // or: taskDirectory: `${__dirname}/tasks`,
  });
  // to clean up: runner.stop()
}

main().catch(err => {
  console.error(err);
  process.exit(1);
});
