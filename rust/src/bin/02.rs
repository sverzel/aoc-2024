advent_of_code::solution!(2);

pub fn part_one(input: &str) -> Option<u32> {
    let mut safe: u32 = 0;

    for line in input.split("\n") {
        let values: Vec<i32> = line
            .split_whitespace()
            .map(|v| v.parse::<i32>().unwrap())
            .collect();

        if is_safe(&values) {
            safe += 1;
        }
    }

    Some(safe)
}

pub fn part_two(input: &str) -> Option<u32> {
    let mut safe: u32 = 0;

    for line in input.split("\n") {
        let v: Vec<i32> = line
            .split_whitespace()
            .map(|v| v.parse::<i32>().unwrap())
            .collect();

        for i in 0..v.len() {
            let mut values = v.clone();
            values.remove(i);

            if is_safe(&values) {
                safe += 1;
                break;
            }
        }
    }

    Some(safe)
}

fn is_safe(v: &Vec<i32>) -> bool {
    let mut a = v.clone();
    a.sort_by(|a, b| a.cmp(b));
    let mut d = v.clone();
    d.sort_by(|a, b| b.cmp(a));

    if v.len() > 0 {
        if (0..v.len() - 1)
            .into_iter()
            .map(|i| (v[i] - v[i + 1]).abs())
            .filter(|&i| i > 0 && i < 4)
            .count()
            == v.len() - 1
            && (v.eq(&a) || v.eq(&d))
        {
            return true;
        }
    }

    false
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let result = part_one(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(407));
    }

    #[test]
    fn test_part_two() {
        let result = part_two(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(459));
    }
}
