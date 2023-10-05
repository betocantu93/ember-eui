/*
 * Copyright Elasticsearch B.V. and/or licensed to Elasticsearch B.V. under one
 * or more contributor license agreements. Licensed under the Elastic License
 * 2.0 and the Server Side Public License, v 1; you may not use this file except
 * in compliance with, at your election, the Elastic License 2.0 or the Server
 * Side Public License, v 1.
 */

import Component from '@glimmer/component';
import {
  timeUnits,
  timeUnitsPlural
} from '../eui-super-date-picker/time-units';
import {
  Milliseconds,
  TimeUnitId,
  RelativeOption,
  ApplyRefreshInterval
} from '../eui-super-date-picker/types/global';
import { keysOf } from '../common';
import { tracked } from '@glimmer/tracking';

const refreshUnitsOptions: RelativeOption[] = keysOf(timeUnits)
  .filter(
    (timeUnit) => timeUnit === 'h' || timeUnit === 'm' || timeUnit === 's'
  )
  .map((timeUnit) => ({ value: timeUnit, text: timeUnitsPlural[timeUnit] }));

const MILLISECONDS_IN_SECOND = 1000;
const MILLISECONDS_IN_MINUTE = MILLISECONDS_IN_SECOND * 60;
const MILLISECONDS_IN_HOUR = MILLISECONDS_IN_MINUTE * 60;

function fromMilliseconds(milliseconds: Milliseconds): EuiRefreshIntervalState {
  const round = (value: number) => parseFloat(value.toFixed(2));
  if (milliseconds > MILLISECONDS_IN_HOUR) {
    return {
      units: 'h',
      value: round(milliseconds / MILLISECONDS_IN_HOUR)
    };
  }

  if (milliseconds > MILLISECONDS_IN_MINUTE) {
    return {
      units: 'm',
      value: round(milliseconds / MILLISECONDS_IN_MINUTE)
    };
  }

  return {
    units: 's',
    value: round(milliseconds / MILLISECONDS_IN_SECOND)
  };
}

function toMilliseconds(units: TimeUnitId, value: Milliseconds) {
  switch (units) {
    case 'h':
      return Math.round(value * MILLISECONDS_IN_HOUR);
    case 'm':
      return Math.round(value * MILLISECONDS_IN_MINUTE);
    case 's':
    default:
      return Math.round(value * MILLISECONDS_IN_SECOND);
  }
}

export interface EuiRefreshIntervalSignature {
  onRefreshChange?: ApplyRefreshInterval;
  isPaused: boolean;
  refreshInterval: Milliseconds;
}

interface EuiRefreshIntervalState {
  value: number | '';
  units: TimeUnitId;
}

export default class EuiAutoRefresh extends Component<EuiRefreshIntervalSignature> {
  @tracked value: string | number = '';
  @tracked units: TimeUnitId = 's';

  get options() {
    return refreshUnitsOptions.find(({ value }) => value === this.units);
  }

  get optionText() {
    return this.options ? this.options.text : '';
  }

  onValueChange = (event: { target: HTMLInputElement }) => {
    const sanitizedValue = parseFloat(event.target.value);
    this.value = isNaN(sanitizedValue) ? '' : sanitizedValue;
    this.applyOnRefreshInterval();
  };

  onUnitsChange = (event: { target?: HTMLSelectElement }) => {
    this.units = event.target?.value as TimeUnitId;
    this.applyOnRefreshInterval();
  };

  startRefresh = () => {
    const { onRefreshChange } = this.args;
    const { value, units } = this;

    if (
      value !== '' &&
      (value as number) > 0 &&
      onRefreshChange !== undefined
    ) {
      onRefreshChange({
        refreshInterval: toMilliseconds(units, value as number),
        isPaused: false
      });
    }
  };

  handleKeyDown = ({ key }: KeyboardEvent) => {
    if (key === 'Enter') {
      this.startRefresh();
    }
  };

  applyOnRefreshInterval = () => {
    const { onRefreshChange, isPaused } = this.args;
    const { units, value } = this;
    if (value === '') {
      return;
    }
    if (!onRefreshChange) {
      return;
    }

    const refreshInterval = toMilliseconds(units, value as number);

    onRefreshChange({
      refreshInterval,
      isPaused: refreshInterval <= 0 ? true : isPaused
    });
  };

  toggleRefresh = () => {
    const { onRefreshChange, isPaused } = this.args;
    const { units, value } = this;

    if (!onRefreshChange || value === '') {
      return;
    }
    onRefreshChange({
      refreshInterval: toMilliseconds(units, value as number),
      isPaused: !isPaused
    });
  };
}
