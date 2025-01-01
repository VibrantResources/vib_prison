CREATE TABLE IF NOT EXISTS `vib_prison` (
    `citizenid` varchar(255) DEFAULT NULL,
    `sentence_duration` bigint DEFAULT 0,
    `reason` text,
    `inmate_items` longtext DEFAULT NULL,
    PRIMARY KEY (`citizenid`),
    UNIQUE KEY `citizenid_UNIQUE` (`citizenid`)
)   ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;