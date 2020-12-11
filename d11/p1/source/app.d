import std.array;
import std.algorithm;
import std.file;
import std.stdio;
import std.string;

void main() {
	char[] input = cast(char[]) read("../input.txt");
	char[][] lines = input.split("\n")[0..$ - 1];
	int height = lines.length;
	int width = lines[0].length;
	bool getOccupied(int x, int y) {
		if (x >= width) return false;
		if (y >= height) return false;
		if (x < 0) return false;
		if (y < 0) return false;
		return lines[y][x] == '#' || lines[y][x] == 'E';
	}
	for (int i = 0; i < 200; i++) {
		for (int x = 0; x < width; x++) {
			for (int y = 0; y < height; y++) {
				int count = 0;
				if (getOccupied(x - 1, y)) count++;
				if (getOccupied(x + 1, y)) count++;
				if (getOccupied(x, y - 1)) count++;
				if (getOccupied(x, y + 1)) count++;
				if (getOccupied(x - 1, y + 1)) count++;
				if (getOccupied(x + 1, y + 1)) count++;
				if (getOccupied(x - 1, y - 1)) count++;
				if (getOccupied(x + 1, y - 1)) count++;
				if (lines[y][x] == '#' && count >= 4) lines[y][x] = 'E';
				if (lines[y][x] == 'L' && count == 0) lines[y][x] = 'F';
			}
		}
		
		for (int x = 0; x < width; x++) {
			for (int y = 0; y < height; y++) {
				if (lines[y][x] == 'F') lines[y][x] = '#';
				if (lines[y][x] == 'E') lines[y][x] = 'L';
			}
		}
	}
	int count = 0;
	for (int x = 0; x < width; x++) {
		for (int y = 0; y < height; y++) {
			if (lines[y][x] == '#') count++;
		}
	}
	writeln(count);
}
