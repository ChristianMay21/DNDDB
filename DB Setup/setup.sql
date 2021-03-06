-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema DND
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DND
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DND` ;
USE `DND` ;

-- -----------------------------------------------------
-- Table `DND`.`Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DND`.`Location` ;

CREATE TABLE IF NOT EXISTS `DND`.`Location` (
  `idLocation` INT NOT NULL,
  `location_name` VARCHAR(45) NULL,
  `location_description` TEXT NULL,
  `superLocation_idLocation` INT NULL,
  PRIMARY KEY (`idLocation`),
  INDEX `fk_Location_Location_idx` (`superLocation_idLocation` ASC),
  CONSTRAINT `fk_Location_Location`
    FOREIGN KEY (`superLocation_idLocation`)
    REFERENCES `DND`.`Location` (`idLocation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DND`.`Creature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DND`.`Creature` ;

CREATE TABLE IF NOT EXISTS `DND`.`Creature` (
  `idCreature` INT NOT NULL,
  `creature_name` VARCHAR(45) NULL,
  `creature_description` TEXT NULL,
  `hp` INT NULL,
  `xp` INT NULL,
  `ac` INT NULL,
  `speed` INT NULL,
  `str` INT NULL,
  `dex` INT NULL,
  `wis` INT NULL,
  `int` INT NULL,
  `con` INT NULL,
  `cha` INT NULL,
  `template_idCreature` INT NULL,
  PRIMARY KEY (`idCreature`),
  INDEX `fk_Creature_Creature1_idx` (`template_idCreature` ASC),
  CONSTRAINT `fk_Creature_Creature1`
    FOREIGN KEY (`template_idCreature`)
    REFERENCES `DND`.`Creature` (`idCreature`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DND`.`CreatureAppearance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DND`.`CreatureAppearance` ;

CREATE TABLE IF NOT EXISTS `DND`.`CreatureAppearance` (
  `Location_idLocation` INT NOT NULL,
  `Creature_idCreature` INT NOT NULL,
  `appearance_specific_information` TEXT NULL,
  PRIMARY KEY (`Location_idLocation`, `Creature_idCreature`),
  INDEX `fk_CreatureAppearance_Location1_idx` (`Location_idLocation` ASC),
  INDEX `fk_CreatureAppearance_Creature1_idx` (`Creature_idCreature` ASC),
  CONSTRAINT `fk_CreatureAppearance_Location1`
    FOREIGN KEY (`Location_idLocation`)
    REFERENCES `DND`.`Location` (`idLocation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CreatureAppearance_Creature1`
    FOREIGN KEY (`Creature_idCreature`)
    REFERENCES `DND`.`Creature` (`idCreature`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DND`.`Attack`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DND`.`Attack` ;

CREATE TABLE IF NOT EXISTS `DND`.`Attack` (
  `idAttack` INT NOT NULL,
  `attack_name` VARCHAR(45) NULL,
  `attack_description` TEXT NULL,
  `attack_modifier` INT NULL,
  PRIMARY KEY (`idAttack`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DND`.`Damage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DND`.`Damage` ;

CREATE TABLE IF NOT EXISTS `DND`.`Damage` (
  `idDamage` INT NOT NULL,
  `damage_type` ENUM('acid', 'bludgeoning', 'cold', 'fire', 'force', 'lightning', 'necrotic', 'piercing', 'poison', 'psychic', 'radiant', 'slashing', 'thunder') NULL,
  `damage_roll` VARCHAR(45) NOT NULL,
  `Attack_idAttack` INT NULL,
  PRIMARY KEY (`idDamage`),
  INDEX `fk_Damage_Attack1_idx` (`Attack_idAttack` ASC),
  CONSTRAINT `fk_Damage_Attack1`
    FOREIGN KEY (`Attack_idAttack`)
    REFERENCES `DND`.`Attack` (`idAttack`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DND`.`CreatureAttack`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DND`.`CreatureAttack` ;

CREATE TABLE IF NOT EXISTS `DND`.`CreatureAttack` (
  `Attack_idAttack` INT NOT NULL,
  `Creature_idCreature` INT NOT NULL,
  `creature_attack_description` TEXT NULL,
  PRIMARY KEY (`Attack_idAttack`, `Creature_idCreature`),
  INDEX `fk_Attack_has_Creature_Creature1_idx` (`Creature_idCreature` ASC),
  INDEX `fk_Attack_has_Creature_Attack1_idx` (`Attack_idAttack` ASC),
  CONSTRAINT `fk_Attack_has_Creature_Attack1`
    FOREIGN KEY (`Attack_idAttack`)
    REFERENCES `DND`.`Attack` (`idAttack`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Attack_has_Creature_Creature1`
    FOREIGN KEY (`Creature_idCreature`)
    REFERENCES `DND`.`Creature` (`idCreature`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DND`.`PlayerCharacter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DND`.`PlayerCharacter` ;

CREATE TABLE IF NOT EXISTS `DND`.`PlayerCharacter` (
  `idPlayerCharacter` INT NOT NULL,
  `pc_name` VARCHAR(45) NOT NULL,
  `pc_xp` VARCHAR(45) NULL,
  PRIMARY KEY (`idPlayerCharacter`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DND`.`Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DND`.`Item` ;

CREATE TABLE IF NOT EXISTS `DND`.`Item` (
  `idItem` INT NOT NULL,
  `item_name` VARCHAR(45) NULL,
  `item_description` TEXT NULL,
  `Location_idLocation` INT NULL,
  `Creature_idCreature` INT NULL,
  `PlayerCharacter_idPlayerCharacter` INT NULL,
  PRIMARY KEY (`idItem`),
  INDEX `fk_Item_Location1_idx` (`Location_idLocation` ASC),
  INDEX `fk_Item_Creature1_idx` (`Creature_idCreature` ASC),
  INDEX `fk_Item_PlayerCharacter1_idx` (`PlayerCharacter_idPlayerCharacter` ASC),
  CONSTRAINT `fk_Item_Location1`
    FOREIGN KEY (`Location_idLocation`)
    REFERENCES `DND`.`Location` (`idLocation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_Creature1`
    FOREIGN KEY (`Creature_idCreature`)
    REFERENCES `DND`.`Creature` (`idCreature`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_PlayerCharacter1`
    FOREIGN KEY (`PlayerCharacter_idPlayerCharacter`)
    REFERENCES `DND`.`PlayerCharacter` (`idPlayerCharacter`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DND`.`ItemAttack`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DND`.`ItemAttack` ;

CREATE TABLE IF NOT EXISTS `DND`.`ItemAttack` (
  `Item_idItem` INT NOT NULL,
  `Attack_idAttack` INT NOT NULL,
  PRIMARY KEY (`Item_idItem`, `Attack_idAttack`),
  INDEX `fk_Item_has_Attack_Attack1_idx` (`Attack_idAttack` ASC),
  INDEX `fk_Item_has_Attack_Item1_idx` (`Item_idItem` ASC),
  CONSTRAINT `fk_Item_has_Attack_Item1`
    FOREIGN KEY (`Item_idItem`)
    REFERENCES `DND`.`Item` (`idItem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_has_Attack_Attack1`
    FOREIGN KEY (`Attack_idAttack`)
    REFERENCES `DND`.`Attack` (`idAttack`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `DND`.`Location`
-- -----------------------------------------------------
START TRANSACTION;
USE `DND`;
INSERT INTO `DND`.`Location` (`idLocation`, `location_name`, `location_description`, `superLocation_idLocation`) VALUES (7, 'Pinnacle, The', 'A magocracy built on a strange landmass that splitts the Flacian River.', NULL);
INSERT INTO `DND`.`Location` (`idLocation`, `location_name`, `location_description`, `superLocation_idLocation`) VALUES (8, 'Wizard\'s Brew, The', 'A tavern.', 7);
INSERT INTO `DND`.`Location` (`idLocation`, `location_name`, `location_description`, `superLocation_idLocation`) VALUES (9, 'Sewers', 'Pretty Gross, but you feel close to some strange magical energies. Compost Portals\n-----------------------\n\nWaste does not simply drain out of the sewer. Instead, that which is not eaten by the cubes drains into a large vat enchanted with necrotic magics. This causes it to quickly decompose. Solid waste is then passed through portals to various fertilizer heaps throughout the farmlands, while liquid waste is passed on to purification vats. 1d6 necrotic damage per turn in vat.\n25% chance of disease.\nAll is well.', 7);
INSERT INTO `DND`.`Location` (`idLocation`, `location_name`, `location_description`, `superLocation_idLocation`) VALUES (10, 'Leytunnels', 'Perfectly round tunnels, 40 feet in diameter. The floor is submerged in about two feet of mercury.', 9);
INSERT INTO `DND`.`Location` (`idLocation`, `location_name`, `location_description`, `superLocation_idLocation`) VALUES (11, 'Knower\'s Lair', 'A hidden door in the side of the tunnel leads to a small decreped room with another, locked door at the back. This actually leads to the Library Vaults, but the Knower can\'t open it.', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `DND`.`Creature`
-- -----------------------------------------------------
START TRANSACTION;
USE `DND`;
INSERT INTO `DND`.`Creature` (`idCreature`, `creature_name`, `creature_description`, `hp`, `xp`, `ac`, `speed`, `str`, `dex`, `wis`, `int`, `con`, `cha`, `template_idCreature`) VALUES (1, 'Magic Rats', 'Every city has rats. But this is the Pinnacle.\nDon\'t mess with the rats.', 1, 10, 13, 20, 3, 10, 10, 9, 9, 6, NULL);
INSERT INTO `DND`.`Creature` (`idCreature`, `creature_name`, `creature_description`, `hp`, `xp`, `ac`, `speed`, `str`, `dex`, `wis`, `int`, `con`, `cha`, `template_idCreature`) VALUES (2, 'Immortal Roaches', 'lol', 4, 500, 30, 20, 10, 10, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `DND`.`Creature` (`idCreature`, `creature_name`, `creature_description`, `hp`, `xp`, `ac`, `speed`, `str`, `dex`, `wis`, `int`, `con`, `cha`, `template_idCreature`) VALUES (3, 'Gray Ooze', 'Looks like stone. Then it melts. Then it eats you. Stealth +2', 22, 100, 8, 10, 12, 6, 16, 1, 6, 2, NULL);
INSERT INTO `DND`.`Creature` (`idCreature`, `creature_name`, `creature_description`, `hp`, `xp`, `ac`, `speed`, `str`, `dex`, `wis`, `int`, `con`, `cha`, `template_idCreature`) VALUES (4, 'Gelatinous Cube', 'Gelatinous cubes scour dungeon passages in silent,\npredictable patterns, leaving perfectly clean paths in\ntheir wake. They consume living tissue while leaving\nbones and other materials undissolved.\nA gelatinous cube is all but transparent, making\nit hard to spot until it attacks. A cube that is well\nfei:l can be easier to spot, since its victims\' bones,\ncoins, and other 9bjects can be seen suspended\ninside the creature.', 84, 450, 6, 15, 14, 3, 1, 6, 20, 6, NULL);
INSERT INTO `DND`.`Creature` (`idCreature`, `creature_name`, `creature_description`, `hp`, `xp`, `ac`, `speed`, `str`, `dex`, `wis`, `int`, `con`, `cha`, `template_idCreature`) VALUES (5, 'Grey Ooze', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3);
INSERT INTO `DND`.`Creature` (`idCreature`, `creature_name`, `creature_description`, `hp`, `xp`, `ac`, `speed`, `str`, `dex`, `wis`, `int`, `con`, `cha`, `template_idCreature`) VALUES (6, 'Flumpf', 'Cute Jellyfish Things. Magical and smart.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `DND`.`Creature` (`idCreature`, `creature_name`, `creature_description`, `hp`, `xp`, `ac`, `speed`, `str`, `dex`, `wis`, `int`, `con`, `cha`, `template_idCreature`) VALUES (7, 'Knower of Secrets', 'Knower of Secrets\n--------------------------\n\nThe Pinnacle has created multiple nothics over the years. Those who were not exterminated straight away often found their way down to the sewers. From there they would peer out of gutters and grates, collecting the secrets they yearn for. \n\nDespite this, there is only ever one Nothic in the Pinnacle at a time. This Nothic is called the Knower of Secrets. Whenever another Nothic is created, it inevitably meets the Knower and learns all of its secrets, before it either kills it or is killed by it.\n\nThe Knower of Secrets knows many of the secrets of the Pinnacle, including a few of the really dangerous ones. Occasionally one might see a big green eye glowing in a sewer grate, collecting knowlege from passerbyers.\n\nTo most residents of the Pinnacle, the Knower of Secrets is just a myth, but the 5 Archmages know about him, and occasionally use his knowlege as a last resort and for political gain. The Knower always asks for something in return, though. A book. A conversation. A magical artifact. Anything to do with the arcane secrets that all Nothics crave.\n\nWhat they might know:\n1: Aniston Tonios and the Spirit Tower\'s connection to Magehaven and Keemin Streka\n2: The plot to keep the lovers apart\n3: The Disaster\n4: If you tell the sewer cubes to \'freeze,\' they will do so\n5: How to control the gollems\n6: The rings required for Arcticle 50\n7: There is a door to the vaults in the leytunnels, but it can only be opened from the other side.', 45 , NULL, 15, 30, 14, 16, 10, 13, 16, 8, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `DND`.`CreatureAppearance`
-- -----------------------------------------------------
START TRANSACTION;
USE `DND`;
INSERT INTO `DND`.`CreatureAppearance` (`Location_idLocation`, `Creature_idCreature`, `appearance_specific_information`) VALUES (9, 1, '');
INSERT INTO `DND`.`CreatureAppearance` (`Location_idLocation`, `Creature_idCreature`, `appearance_specific_information`) VALUES (9, 2, NULL);
INSERT INTO `DND`.`CreatureAppearance` (`Location_idLocation`, `Creature_idCreature`, `appearance_specific_information`) VALUES (9, 3, NULL);
INSERT INTO `DND`.`CreatureAppearance` (`Location_idLocation`, `Creature_idCreature`, `appearance_specific_information`) VALUES (9, 4, NULL);
INSERT INTO `DND`.`CreatureAppearance` (`Location_idLocation`, `Creature_idCreature`, `appearance_specific_information`) VALUES (9, 5, NULL);
INSERT INTO `DND`.`CreatureAppearance` (`Location_idLocation`, `Creature_idCreature`, `appearance_specific_information`) VALUES (10, 6, '');
INSERT INTO `DND`.`CreatureAppearance` (`Location_idLocation`, `Creature_idCreature`, `appearance_specific_information`) VALUES (10, 7, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `DND`.`Attack`
-- -----------------------------------------------------
START TRANSACTION;
USE `DND`;
INSERT INTO `DND`.`Attack` (`idAttack`, `attack_name`, `attack_description`, `attack_modifier`) VALUES (1, 'claw', '', -3);
INSERT INTO `DND`.`Attack` (`idAttack`, `attack_name`, `attack_description`, `attack_modifier`) VALUES (2, 'bite', '', -2);
INSERT INTO `DND`.`Attack` (`idAttack`, `attack_name`, `attack_description`, `attack_modifier`) VALUES (3, 'claw', '', +4);
INSERT INTO `DND`.`Attack` (`idAttack`, `attack_name`, `attack_description`, `attack_modifier`) VALUES (4, 'Rotting Gaze', '30 ft. range, DC12 Const Save', NULL);
INSERT INTO `DND`.`Attack` (`idAttack`, `attack_name`, `attack_description`, `attack_modifier`) VALUES (5, 'Pseudopod', '', +4);
INSERT INTO `DND`.`Attack` (`idAttack`, `attack_name`, `attack_description`, `attack_modifier`) VALUES (6, 'Pseudopod', '', +3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `DND`.`Damage`
-- -----------------------------------------------------
START TRANSACTION;
USE `DND`;
INSERT INTO `DND`.`Damage` (`idDamage`, `damage_type`, `damage_roll`, `Attack_idAttack`) VALUES (1, 'piercing', '1d4-3', 1);
INSERT INTO `DND`.`Damage` (`idDamage`, `damage_type`, `damage_roll`, `Attack_idAttack`) VALUES (2, 'piercing', '1d4-2', 2);
INSERT INTO `DND`.`Damage` (`idDamage`, `damage_type`, `damage_roll`, `Attack_idAttack`) VALUES (3, 'acid', '2d6', 6);
INSERT INTO `DND`.`Damage` (`idDamage`, `damage_type`, `damage_roll`, `Attack_idAttack`) VALUES (4, 'acid', '3d6', 5);
INSERT INTO `DND`.`Damage` (`idDamage`, `damage_type`, `damage_roll`, `Attack_idAttack`) VALUES (5, 'bludgeoning', '1d6+1', 6);
INSERT INTO `DND`.`Damage` (`idDamage`, `damage_type`, `damage_roll`, `Attack_idAttack`) VALUES (6, 'piercing', '3d6+1', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `DND`.`CreatureAttack`
-- -----------------------------------------------------
START TRANSACTION;
USE `DND`;
INSERT INTO `DND`.`CreatureAttack` (`Attack_idAttack`, `Creature_idCreature`, `creature_attack_description`) VALUES (1, 1, '');
INSERT INTO `DND`.`CreatureAttack` (`Attack_idAttack`, `Creature_idCreature`, `creature_attack_description`) VALUES (1, 2, NULL);
INSERT INTO `DND`.`CreatureAttack` (`Attack_idAttack`, `Creature_idCreature`, `creature_attack_description`) VALUES (3, 6, '');
INSERT INTO `DND`.`CreatureAttack` (`Attack_idAttack`, `Creature_idCreature`, `creature_attack_description`) VALUES (4, 5, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `DND`.`PlayerCharacter`
-- -----------------------------------------------------
START TRANSACTION;
USE `DND`;
INSERT INTO `DND`.`PlayerCharacter` (`idPlayerCharacter`, `pc_name`, `pc_xp`) VALUES (1, 'Risio', '17397');
INSERT INTO `DND`.`PlayerCharacter` (`idPlayerCharacter`, `pc_name`, `pc_xp`) VALUES (2, 'Oghren', '17398');
INSERT INTO `DND`.`PlayerCharacter` (`idPlayerCharacter`, `pc_name`, `pc_xp`) VALUES (3, 'Milo', '16998');
INSERT INTO `DND`.`PlayerCharacter` (`idPlayerCharacter`, `pc_name`, `pc_xp`) VALUES (4, 'Silence', '17397');
INSERT INTO `DND`.`PlayerCharacter` (`idPlayerCharacter`, `pc_name`, `pc_xp`) VALUES (5, 'Sophia', '17300');

COMMIT;


-- -----------------------------------------------------
-- Data for table `DND`.`Item`
-- -----------------------------------------------------
START TRANSACTION;
USE `DND`;
INSERT INTO `DND`.`Item` (`idItem`, `item_name`, `item_description`, `Location_idLocation`, `Creature_idCreature`, `PlayerCharacter_idPlayerCharacter`) VALUES (1, 'Naadia Portel\'s Cloak', 'Makes the wearer resistant to fire.', NULL, NULL, 1);
INSERT INTO `DND`.`Item` (`idItem`, `item_name`, `item_description`, `Location_idLocation`, `Creature_idCreature`, `PlayerCharacter_idPlayerCharacter`) VALUES (2, 'Weird Ring', ' ', NULL, 7, NULL);
INSERT INTO `DND`.`Item` (`idItem`, `item_name`, `item_description`, `Location_idLocation`, `Creature_idCreature`, `PlayerCharacter_idPlayerCharacter`) VALUES (3, 'Black Book', '', 11, NULL, NULL);

COMMIT;

