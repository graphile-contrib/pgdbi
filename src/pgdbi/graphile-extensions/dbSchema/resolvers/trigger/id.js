const clog = require('fbkt-clog');

module.exports = build => {
  return async (_trigger, args, context, resolveInfo) => {
    const { pgSql: sql } = build;
    try {
      const eventManipulation = _trigger.eventManipulation;
      const eventObjectSchema = _trigger.eventObjectSchema;
      const eventObjectTable = _trigger.eventObjectTable;
      const actionTiming = _trigger.actionTiming;

      return `trigger:${actionTiming}.${eventManipulation}.${eventObjectSchema}.${eventObjectTable}`;
    } catch (e) {
      throw e;
    }
  };
};
