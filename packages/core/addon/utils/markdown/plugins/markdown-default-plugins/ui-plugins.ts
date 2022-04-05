/*
 * Copyright Elasticsearch B.V. and/or licensed to Elasticsearch B.V. under one
 * or more contributor license agreements. Licensed under the Elastic License
 * 2.0 and the Server Side Public License, v 1; you may not use this file except
 * in compliance with, at your election, the Elastic License 2.0 or the Server
 * Side Public License, v 1.
 */

import * as MarkdownTooltip from '../markdown-tooltip';
import { EuiMarkdownEditorUiPlugin } from '../../markdown-types';

export type DefaultEuiMarkdownUiPlugins = EuiMarkdownEditorUiPlugin[];

export const getDefaultEuiMarkdownUiPlugins = ({
  exclude
}: { exclude?: Array<'tooltip'> } = {}): DefaultEuiMarkdownUiPlugins => {
  const excludeSet = new Set(exclude);
  const uiPlugins = [];

  if (!excludeSet.has('tooltip')) uiPlugins.push(MarkdownTooltip.plugin);

  // @ts-ignore __originatedFromEui is a custom property
  uiPlugins.__originatedFromEui = true;
  return uiPlugins;
};

export const defaultUiPlugins = getDefaultEuiMarkdownUiPlugins();