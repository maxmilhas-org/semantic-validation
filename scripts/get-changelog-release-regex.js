#!/usr/bin/env node

const { existsSync, readFileSync } = require('fs');
const defaultTypes = new Set(['fix', 'feat', 'perf', 'revert']);

function validateSemanticReleaseRules(item) {
  return Array.isArray(item) && item[0] === '@semantic-release/commit-analyzer' && item[1] && Array.isArray(item[1].releaseRules);
}

function processSemanticRelease(release) {
  release.plugins.forEach((item) => {
    if (validateSemanticReleaseRules(item)) {
      item[1].releaseRules.forEach((rule) => {
        if (rule.type) {
          if (rule.release) {
            defaultTypes.add(rule.type);
          } else {
            defaultTypes.delete(rule.type);
          }
        }
      });
    }
  });
}


try {
  if (existsSync('.releaserc.json')) {
    const release = JSON.parse(readFileSync('.releaserc.json'));
    if (Array.isArray(release.plugins)) {
      processSemanticRelease(release);
    }
  }
} catch (err) {
  // Let's just ignore it for now
}

console.log(`^\\s*(?:${Array.from(defaultTypes).join('|')})(?:\\(.*\\))?:`);
