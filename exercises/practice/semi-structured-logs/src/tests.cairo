use semi_structured_logs::{error, info, log, warn, LogLevel};

#[test]
fn emits_info() {
    assert_eq!(info("Timezone changed"), "[INFO]: Timezone changed");
}

#[test]
fn emits_warning() {
    assert_eq!(warn("Timezone not set"), "[WARNING]: Timezone not set");
}

#[test]
fn emits_error() {
    assert_eq!(error("Disk full"), "[ERROR]: Disk full");
}

#[test]
fn log_emits_info() {
    assert_eq!(log(LogLevel::Info, "Timezone changed"), "[INFO]: Timezone changed");
}

#[test]
fn log_emits_warning() {
    assert_eq!(log(LogLevel::Warning, "Timezone not set"), "[WARNING]: Timezone not set");
}

#[test]
fn log_emits_error() {
    assert_eq!(log(LogLevel::Error, "Disk full"), "[ERROR]: Disk full");
}

#[test]
fn add_a_variant() {
    assert_eq!(log(LogLevel::Debug, "reached line 123"), "[DEBUG]: reached line 123",);
}
