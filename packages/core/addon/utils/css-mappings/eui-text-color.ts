export const baseClass = 'euiTextColor';

export const colorMapping = {
  default: `${baseClass}--default`,
  subdued: `${baseClass}--subdued`,
  secondary: `${baseClass}--secondary`,
  accent: `${baseClass}--accent`,
  danger: `${baseClass}--danger`,
  warning: `${baseClass}--warning`,
  ghost: `${baseClass}--ghost`
};

const mapping: ComponentMapping = {
  base: baseClass,
  properties: {
    color: colorMapping
  }
};

export default mapping;
