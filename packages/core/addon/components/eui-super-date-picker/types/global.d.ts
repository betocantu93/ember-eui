export interface DurationRange {
  end: ShortDate;
  label?: string;
  start: ShortDate;
}

export type ShortDate = NowDateMode | string;

export type NowDateMode = 'now';

export type TimeUnitId = 's' | 'm' | 'h' | 'd' | 'w' | 'M' | 'y';

export type TimeUnitFromNowId = 's+' | 'm+' | 'h+' | 'd+' | 'w+' | 'M+' | 'y+';

export type TimeUnitLabel =
  | 'second'
  | 'minute'
  | 'hour'
  | 'day'
  | 'week'
  | 'month'
  | 'year';
export type TimeUnitLabelPlural =
  | 'seconds'
  | 'minutes'
  | 'hours'
  | 'days'
  | 'weeks'
  | 'months'
  | 'years';

export interface RelativeParts {
  count: number;
  round: boolean;
  roundUnit?: TimeUnitId;
  unit: string;
}

export type Milliseconds = number;

export interface RelativeOption {
  text: string;
  value: TimeUnitAllId;
}

export type TimeUnitAllId = TimeUnitId | TimeUnitFromNowId;

export type OnRefreshChangeArgs = {
  isPaused: boolean;
  refreshInterval: number;
};

export type ApplyRefreshInterval = (args: OnRefreshChangeArgs) => void;

interface ApplyTimeArgs extends DurationRange {
  start: string;
  end: string;
  keepPopoverOpen?: boolean;
  quickSelect?: QuickSelect;
}
export type ApplyTime = (args: ApplyTimeArgs) => void;

export interface QuickSelect {
  timeTense: string;
  timeValue: number;
  timeUnits: TimeUnitId;
}
