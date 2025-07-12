/**
 * Below are the colors that are used in the app. The colors are defined in the light and dark mode.
 * There are many other ways to style your app. For example, [Nativewind](https://www.nativewind.dev/), [Tamagui](https://tamagui.dev/), [unistyles](https://reactnativeunistyles.vercel.app), etc.
 */

const tintColorLight = '#FF8C00'; // A vibrant orange for light mode
const tintColorDark = '#FFA500'; // A slightly brighter orange for dark mode tint

export const Colors = {
  light: {
    text: '#11181C', // Dark grey for text
    background: '#fff', // White background
    tint: tintColorLight, // Primary orange for active elements
    icon: '#DD7816', // A darker orange for general icons
    tabIconDefault: '#DD7816', // Light grey for default tab icons
    tabIconSelected: tintColorLight, // Selected tab icon matches tint
  },
  dark: {
    text: '#ECEDEE', // Light grey for text on dark background
    background: '#151718', // Very dark grey background
    tint: tintColorDark, // Brighter orange for active elements on dark mode
    icon: '#FFB84C', // A lighter orange for general icons on dark mode
    tabIconDefault: '#9BA1A6', // Medium grey for default tab icons
    tabIconSelected: tintColorDark, // Selected tab icon matches dark tint
  },
};
