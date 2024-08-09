﻿namespace NinjaOne {
    public enum EntityType {
        ORGANIZATION = 1,
        DOCUMENT = 2,
        LOCATION = 3,
        NODE = 4,
        ATTACHMENT = 5,
        TECHNICIAN = 6,
        CREDENTIAL = 7,
        CHECKLIST = 8,
        END_USER = 9,
        CONTACT = 10,
        KB_DOCUMENT = 11
    }
    public enum FilterOperator {
        present = 1,
        not_present = 2,
        @is = 3,
        is_not = 4,
        contains = 5,
        not_contains = 6,
        contains_any = 7,
        contains_none = 8,
        greater_than = 9,
        less_than = 10,
        greater_or_equal_than = 11,
        less_or_equal_than = 12,
        between = 13
    }
}
