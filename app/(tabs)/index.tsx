import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";

export default function Groups() {
    return (
        <ThemedView
            style={{
                flex: 1,
                justifyContent: "center",
                alignItems: "center",
            }}
        >
            <ThemedText>Groups</ThemedText>
        </ThemedView>
    );
}