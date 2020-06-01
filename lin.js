const pglint = require('pglint').pglint


async function doit(){
  console.log(pglint)

  const result = await pglint({
    connectionString: 'postgres://postgres:1234@0.0.0.0/lcb',
    project: 'stlbucket/pgdbi-try',
    token: '0dc056d563216b428314add7'
    }
  )

  console.log('result', result)
}

doit()