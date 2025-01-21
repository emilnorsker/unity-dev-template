using System.Collections;
using NUnit.Framework;
using UnityEngine;
using UnityEngine.TestTools;

public class TestExample
{
    [Test]
    public void SimpleAddition_WhenAddingOneAndOne_ReturnsTwo()
    {
        // Arrange
        int a = 1;
        int b = 1;  // Fixed: Changed from 2 to 1
        
        // Act
        int result = a + b;
        
        // Assert
        Assert.That(result, Is.EqualTo(2), "Basic addition of 1 + 1 should equal 2");
    }
}
