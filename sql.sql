CREATE TABLE IF NOT EXISTS `gifts` (
    `id` int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `claimed` int(1) NOT NULL DEFAULT 0,
    `identifier` varchar(80)
);