import { useBackend } from '../backend';
import { Box, Button, InfinitePlane, LabeledList, ObjectComponent, Section, Stack } from '../components';
import { NtosWindow, Window } from '../layouts';
import { resolveAsset } from '../assets';
import { clamp } from 'common/math';
import {
  KEY_SPACE,
} from 'common/keycodes';

export class SignalWindow extends InfinitePlane {
  handleMouseMove(event) {
    const {
      onBackgroundMoved,
      initialLeft = 0,
      initialTop = 0,
    } = this.props;
    if (this.state.mouseDown) {
      let newX, newY;
      this.setState((state) => {
        newX = clamp(event.clientX - state.lastLeft, -1000, 1000);
        newY = clamp(event.clientY - state.lastTop, -1000, 1000);
        return {
          left: newX,
          top: newY,
        };
      });
      if (onBackgroundMoved) {
        onBackgroundMoved(newX+initialLeft, newY+initialTop);
      }
    }
  }

  render() {
    let rendering = (
      <Stack />
    );

    return super.render();
  }
}


export const SignalScanner = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    signals = [{ "name": "explotano", "left": "50px", "top": "0px" }, { "name": "fuck", "left": "-20px", "top": "20px" }],
  } = data;

  return (
    <Window resizable>
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <SignalWindow
              backgroundImage={resolveAsset('grid_background.png')}
              imageWidth={600}
              initialLeft={0}
              initialTop={0}
              onKeyDown={(e) => {
                if (e.keyCode === KEY_SPACE) {
                  e.preventDefault();
                  act('the_funny', { var: "pressed" });
                } }}
            >
              {
                signals.map(signal => (
                  <Box
                    position="absolute"
                    left={signal.left}
                    top={signal.top}
                    key={signal.name}
                  >
                    {`${signal.name}\n${signal.left}\n${signal.top}`}
                  </Box>
                ))
              }
            </SignalWindow>
          </Stack.Item>
          <Stack.Item grow>
            Test
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
