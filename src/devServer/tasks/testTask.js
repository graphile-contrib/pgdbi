// tasks/testTask.js
module.exports = async (payload, { debug }) => {
  // async is optional, but best practice
  debug(`Received ${JSON.stringify(payload)}`);
};
