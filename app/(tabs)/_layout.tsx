import { Tabs } from 'expo-router';
import React from 'react';
import { Platform } from 'react-native';

import { HapticTab } from '@/components/HapticTab';
import { ThemedText } from '@/components/ThemedText';
import { ThemedView } from '@/components/ThemedView';
import TabBarBackground from '@/components/ui/TabBarBackground';
import { Colors } from '@/constants/Colors';
import { useColorScheme } from '@/hooks/useColorScheme';
import { AntDesign, MaterialCommunityIcons } from '@expo/vector-icons';

export default function TabLayout() {
  const colorScheme = useColorScheme();

  return (
    <Tabs
      screenOptions={{
        tabBarActiveTintColor: Colors[colorScheme ?? 'light'].tint,
        headerShown: true,
        tabBarButton: HapticTab,
        tabBarBackground: TabBarBackground,
        tabBarStyle: Platform.select({
          ios: {
            // Use a transparent background on iOS to show the blur effect
            position: 'absolute',
          },
          default: {},
        }),
        headerTintColor: Colors[colorScheme ?? 'light'].tint, // Header text color
        headerTitleStyle: {
          fontWeight: 'bold',
          fontSize: 24,
        },
        headerTitleAlign: 'left', // Align title to the left
        headerTitle: () => {
          return <ThemedView style={{ flexDirection: "row" }}>
            <ThemedText type='subtitle'>2gezer</ThemedText>
            <MaterialCommunityIcons style={{ transform: 'rotate(-20deg)', marginEnd: -16 }} size={28} name="carrot" color={Colors[colorScheme ?? 'light'].tint} />
            <MaterialCommunityIcons style={{ transform: 'rotate(20deg)rotateY(180deg)' }} size={28} name="carrot" color={Colors[colorScheme ?? 'light'].tint} />
          </ThemedView>;
        }, // The main title of the app
      }}>
      <Tabs.Screen
        name="index"
        options={{
          title: 'Groups',
          tabBarIcon: ({ color }) => <MaterialCommunityIcons size={28} name="account-group" color={color} />,
        }}
      />
      <Tabs.Screen
        name="apps"
        options={{
          title: 'Apps',
          tabBarIcon: ({ color }) => <AntDesign name="appstore-o" size={22} color={color} />,
        }}
      />
    </Tabs>
  );
}
