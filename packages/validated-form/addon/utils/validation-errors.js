/**
 * For code taken from ember-cp-validations
 * Copyright 2016, Yahoo! Inc.
 * Copyrights licensed under the New BSD License. See the accompanying LICENSE file for terms.
 */
import { get } from '@ember/object';

import { assert } from '@ember/debug';
import { assign } from '@ember/polyfills';
import config from 'ember-get-config';
import getMessages from './get-messages';

export default function buildMessage(key, result) {
  let returnsRaw = get(config, 'changeset-validations.rawOutput') || false;
  let messages = getMessages();

  let description = messages.getDescriptionFor(key);

  if (result.message) {
    return result.message;
  }

  let { type, value, context = {} } = result;

  let message = get(messages, type);
  if (returnsRaw) {
    context = assign({}, context, { description });
    return { value, type, message, context };
  }

  if (context.message) {
    let message = context.message;

    if (typeof message === 'function') {
      let builtMessage = message(key, type, value, context);
      assert(
        'Custom message function must return a string',
        typeof builtMessage === 'string'
      );

      return builtMessage;
    }

    return messages.formatMessage(message, assign({ description }, context));
  }

  return messages.formatMessage(message, assign({ description }, context));
}
