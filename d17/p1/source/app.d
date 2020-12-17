import std.algorithm;
import std.conv;
import std.file;
import std.stdio;
import std.string;

alias MapArr = char[13][20][20];

void main() {
	string input = cast(string) read("../input.txt");
	string[] lines = input.split("\n")[0..$ - 1];
	MapArr map;
	foreach (int x; 0..20) {
		foreach (int y; 0..20) {
			foreach (int z; 0..13) {
				map[x][y][z] = '.';
			}
		}
	}
	foreach (int l, string line; lines) {
		foreach (int i, char c; line) {
			map[6 + i][6 + l][6] = c;
		}
	}
	int countAdj(int x, int y, int z) {
		int c;
		for (int xl = x - 1; xl <= x + 1; xl++) {
			for (int yl = y - 1; yl <= y + 1; yl++) {
				for (int zl = z - 1; zl <= z + 1; zl++) {
					if (xl == x && yl == y && zl == z) continue;
					if (xl < 0 || yl < 0 || zl < 0) continue;
					if (xl >= 20 || yl >= 20 || zl >= 13) continue;
					if (map[xl][yl][zl] == '#') c++;
				}
			}
		}
		return c;
	}
	for (int cycle = 0; cycle < 6; cycle++) {
		MapArr result = map.dup;
		foreach (int x; 0..20) {
			foreach (int y; 0..20) {
				foreach (int z; 0..13) {
					int total = countAdj(x, y, z);
					if (map[x][y][z] == '#') {
						if (total != 2 && total != 3) {
							result[x][y][z] = '.';
						}
					} else {
						if (total == 3) {
							result[x][y][z] = '#';
						}
					}
				}
			}
		}
		map = result.dup;
	}
	ulong total;
	foreach (int x; 0..20) {
		foreach (int y; 0..20) {
			foreach (int z; 0..13) {
				if (map[x][y][z] == '#') {
					total++;
				}
			}
		}
	}
	writeln(total);
}
