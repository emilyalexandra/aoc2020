import std.algorithm;
import std.array;
import std.file;
import std.stdio;
import std.string;

string[][string] possibles;

string[] allIngredients;
int[string] appearances;

void main() {
	string input = cast(string) read("../input.txt");
	string[] lines = input.split("\n")[0..$ - 1];
	foreach (string line; lines) {
		string[] parts = line.split(" (");
		string[] ingredients = parts[0].split(' ');
		string[] alergens = parts[1][9..$ - 1].split(", ");
		foreach (string alergen; alergens) {
			if (alergen in possibles) {
				possibles[alergen] = possibles[alergen].filter!(a => ingredients.canFind(a)).array;
			} else {
				possibles[alergen] = ingredients.dup;
			}
		}
		foreach (string ingredient; ingredients) {
			if (!allIngredients.canFind(ingredient)) {
				allIngredients ~= ingredient;
			}
			appearances[ingredient]++;
		}
	}
	int total;
	foreach (string key, int value; appearances) {
		if (!possibles.byValue.canFind!((string[] p, k) => p.canFind(k))(key)) {
			total += value;
		}
	}
	writeln(total);
}
