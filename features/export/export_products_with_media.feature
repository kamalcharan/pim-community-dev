@javascript
Feature: Export products with media
  In order to re-use the images and documents I have set on my products
  As a product manager
  I need to be able to export them along with the products

  Background:
    Given a "footwear" catalog configuration
    And the following job "footwear_product_export" configuration:
      | filePath | %tmp%/product_export/product_export.csv |
    And I am logged in as "Julia"

  Scenario: Successfully export products with media
    Given the following products:
      | sku      | family   | categories        | price          | size | color    | name-en_US |
      | SNKRS-1B | sneakers | summer_collection | 50 EUR, 70 USD | 45   | black    | Model 1    |
      | SNKRS-1R | sneakers | summer_collection | 50 EUR, 70 USD | 45   | red      | Model 1    |
      | SNKRS-1C | sneakers | summer_collection | 55 EUR, 75 USD | 45   | charcoal | Model 1    |
    And the following product values:
      | product  | attribute | value                     |
      | SNKRS-1R | side_view | %fixtures%/SNKRS-1R.png   |
      | SNKRS-1C | side_view | %fixtures%/SNKRS-1C-s.png |
      | SNKRS-1C | top_view  | %fixtures%/SNKRS-1C-t.png |
    And I launched the completeness calculator
    And I am on the "footwear_product_export" export job page
    When I launch the export job
    And I wait for the "footwear_product_export" job to finish
    Then exported file of "footwear_product_export" should contain:
    """
    sku;family;groups;categories;color;description-en_US-mobile;lace_color;manufacturer;name-en_US;price-EUR;price-USD;rating;side_view;size;top_view;weather_conditions;enabled
    SNKRS-1B;sneakers;;summer_collection;black;;;;"Model 1";50.00;70.00;;;45;;;1
    SNKRS-1R;sneakers;;summer_collection;red;;;;"Model 1";50.00;70.00;;files/SNKRS-1R/side_view/SNKRS-1R.png;45;;;1
    SNKRS-1C;sneakers;;summer_collection;charcoal;;;;"Model 1";55.00;75.00;;files/SNKRS-1C/side_view/SNKRS-1C-s.png;45;files/SNKRS-1C/top_view/SNKRS-1C-t.png;;1

    """
    And export directory of "footwear_product_export" should contain the following media:
      | files/SNKRS-1R/side_view/SNKRS-1R.png   |
      | files/SNKRS-1C/side_view/SNKRS-1C-s.png |
      | files/SNKRS-1C/top_view/SNKRS-1C-t.png  |

  @jira https://akeneo.atlassian.net/browse/PIM-3785
  Scenario: Successfully export products with nullable media
    Given the following family:
      | code      |
      | flipflop  |
    And the following attributes:
      | code    | label   | type  | allowed extensions | families  |
      | picture | Picture | image | jpg                | flipflop  |
    And the following products:
      | sku         | categories        | price          | size | color    | name-en_US | family    |
      | FLIPFLOP-1R | summer_collection | 50 EUR, 70 USD | 45   | red      | Model 1    | flipflop  |
      | FLIPFLOP-1C | summer_collection | 55 EUR, 75 USD | 45   | charcoal | Model 1    | flipflop  |
      | FLIPFLOP-1B | summer_collection | 50 EUR, 70 USD | 45   | black    | Model 1    | flipflop  |
    And I am on the products page
    And I mass-edit products FLIPFLOP-1R and FLIPFLOP-1C
    And I choose the "Edit attributes" operation
    And I display the Picture attribute
    And I attach file "akeneo.jpg" to "Picture"
    And I move on to the next step
    Then the file "picture" of products FLIPFLOP-1R and FLIPFLOP-1C should be "akeneo.jpg"
    And I am on the products page
    And I mass-edit products FLIPFLOP-1C
    And I choose the "Edit attributes" operation
    And I display the Picture attribute
    And I attach file "" to "Picture"
    And I move on to the next step
    And I launched the completeness calculator
    And I am on the "footwear_product_export" export job page
    When I launch the export job
    And I wait for the "footwear_product_export" job to finish
    Then exported file of "footwear_product_export" should contain:
    """
    sku;family;groups;categories;color;name-en_US;picture;price-EUR;price-USD;size;enabled
    FLIPFLOP-1R;flipflop;;summer_collection;;;files/FLIPFLOP-1R/picture/akeneo.jpg;;;;1
    FLIPFLOP-1C;flipflop;;summer_collection;;;;;;;1
    FLIPFLOP-1B;flipflop;;summer_collection;black;"Model 1";;50.00;70.00;45;1

    """
    And export directory of "footwear_product_export" should contain the following media:
      | files/FLIPFLOP-1R/picture/akeneo.jpg |
