advent_of_code::solution!(1);

pub fn part_one(input: &str) -> Option<u32> {
    let mut left = vec![];
    let mut right = vec![];
    for line in input.split("\n") {
        let value: Vec<&str> = line.split_whitespace().collect();
        if value.len() > 0 {
            left.push(value[0].parse::<i32>().unwrap());
            right.push(value[1].parse::<i32>().unwrap());
        }
    }

    left.sort();
    right.sort();

    let mut sum: u32 = 0;
    for i in 0..left.len() {
        sum += (left[i] - right[i]).abs() as u32;
    }

    Some(sum)
}

pub fn part_two(input: &str) -> Option<u32> {
    let mut left = vec![];
    let mut right = vec![];
    for line in input.split("\n") {
        let value: Vec<&str> = line.split_whitespace().collect();
        if value.len() > 0 {
            left.push(value[0].parse::<i32>().unwrap());
            right.push(value[1].parse::<i32>().unwrap());
        }
    }

    left.sort();
    right.sort();

    let mut sum: u32 = 0;
    for l in left {
        sum += (l * (&right).into_iter().filter(|&v| *v == l).count() as i32) as u32;
    }

    Some(sum)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let result = part_one(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(2066446));
    }

    #[test]
    fn test_part_two() {
        let result = part_two(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(24931009));
    }
}
