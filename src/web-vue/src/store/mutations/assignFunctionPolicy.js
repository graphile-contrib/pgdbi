function assignTablePolicy(state, functionId, policyDefinitionId) {
  const stuff = state.managedSchemata.reduce(
    (stuff, schema) => {
      if (stuff.currentSchema) {
        return stuff;
      } else {
        const aFunction = schema.schemaFunctions.find(t => t.id === functionId);
        if (aFunction) {
          return {
            ...stuff,
            currentSchema: schema,
            currentFunction: aFunction,
          };
        } else {
          return stuff;
        }
      }
    },
    {
      currentSchema: null,
      currentFunction: null,
    },
  );

  const schema = stuff.currentSchema;
  const aFunction = stuff.currentFunction;

  const otherSchemata = state.managedSchemata.filter(s => s.id !== schema.id);
  const otherFunctions = schema.schemaFunctions.filter(
    t => t.id !== aFunction.id,
  );

  state.managedSchemata = [
    ...otherSchemata,
    {
      ...schema,
      schemaFunctions: [
        ...otherFunctions,
        {
          ...aFunction,
          functionPolicyDefinitionId: policyDefinitionId,
        },
      ],
    },
  ];

  return state;
}

function assignAll(state, payload) {
  const functionIds = payload.functionIds;
  const policyDefinitionId = payload.policyDefinitionId;

  functionIds.reduce((state, functionId) => {
    return assignTablePolicy(state, functionId, policyDefinitionId);
  }, state);
}

export default assignAll;
