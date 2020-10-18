import { helper } from '@ember/component/helper';
import { assert } from '@ember/debug';
import { isPresent } from '@ember/utils';

// Mappings registry
import cssMappings from '../utils/css-mappings';

interface Options {
  size: string;
  padding: string;
  textAlign: string;
  color: string;
  verticalPosition: string;
  horizontalPosition: string;
  componentName: string;
  textTransform: string;
}

/**
 * Joins a list of classes
 *
 * @param classes - List of classes that will be joined
 */
export function classNames(
  classNames: string[] = [],
  {
    componentName,
    size,
    padding,
    verticalPosition,
    horizontalPosition,
    textAlign,
    color,
    textTransform,
  }: Options
): string {
  let classes: string[] = [...classNames];
  if (componentName) {
    assert(
      `The component '${componentName}' doesn't have mappings defined`,
      cssMappings[componentName] !== undefined
    );
    classes.push(cssMappings[componentName].base || '');
    classes.push(cssMappings[componentName].properties.size?.[size] || '');
    classes.push(cssMappings[componentName].properties.padding?.[padding] || '');
    classes.push(cssMappings[componentName].properties.verticalPosition?.[verticalPosition] || '');
    classes.push(
      cssMappings[componentName].properties.horizontalPosition?.[horizontalPosition] || ''
    );
    classes.push(cssMappings[componentName].properties.textAlign?.[textAlign] || '');
    classes.push(cssMappings[componentName].properties.color?.[color] || '');
    classes.push(cssMappings[componentName].properties.textTransform?.[textTransform] || '');
    classes = classes.filter(s => isPresent(s));
  }

  return classes.join(' ');
}

export default helper(classNames);