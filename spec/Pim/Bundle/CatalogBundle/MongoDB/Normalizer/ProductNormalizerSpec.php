<?php

namespace spec\Pim\Bundle\CatalogBundle\MongoDB\Normalizer;

use PhpSpec\ObjectBehavior;
use Prophecy\Argument;
use Pim\Bundle\CatalogBundle\Model\ProductInterface;
use Pim\Bundle\CatalogBundle\Entity\Family;
use Symfony\Component\Serializer\SerializerInterface;

class ProductNormalizerSpec extends ObjectBehavior
{
    function it_is_a_serializer_aware_normalizer()
    {
        $this->shouldImplement('Symfony\Component\Serializer\Normalizer\NormalizerInterface');
        $this->shouldImplement('Symfony\Component\Serializer\SerializerAwareInterface');
    }

    function it_supports_normalization_in_bson_of_product(ProductInterface $product)
    {
        $this->supportsNormalization($product, 'bson')->shouldBe(true);
        $this->supportsNormalization($product, 'json')->shouldBe(false);
        $this->supportsNormalization($product, 'xml')->shouldBe(false);
    }

    function it_normalizes_product(
        SerializerInterface $serializer,
        ProductInterface $product,
        Family $family
    ) {
        $serializer->implement('Symfony\Component\Serializer\Normalizer\NormalizerInterface');
        $this->setSerializer($serializer);

        $product->getFamily()->willReturn($family);
        $product->getValues()->willReturn([]);

        $serializer->normalize($family, 'bson', [])->willReturn('family normalization');

        $this->normalize($product, 'bson', [])->shouldReturn([
            'family' => 'family normalization'
        ]);
    }

    function it_cannot_normalize_when_injected_serializer_is_not_a_normalizer(
        SerializerInterface $serializer,
        ProductInterface $product
    ) {
        $this->setSerializer($serializer);

        $this->shouldThrow('\LogicException')->duringNormalize($product, 'bson', []);
    }
}
